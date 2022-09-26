//
//  AsyncRequest.swift
//  Youssef
//
//  Created by Youssef on 7/14/22.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation
import Alamofire
import Combine

typealias RequestPublisher<T: Codable> = AnyPublisher<NetworkState<T>, Never>

class AsyncRequest<T> where T: Codable {
    private let body: JsonEncadable?
    private let url: RequestUrl
    private let method: HTTPMethod
    
    private let interceptor = AppRequestInterceptor()
    
    init(url: RequestUrl, method: HTTPMethod, body: JsonEncadable? = nil) {
        self.body = body
        self.url = url
        self.method = method
    }
    
    private lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration, interceptor: interceptor)
    }()
    
    @discardableResult
    func asPublisher() async -> RequestPublisher<T> {
        let result: NetworkState<T> = await withCheckedContinuation { continuation in
            sessionManager
                .request(url.value, method: method, parameters: body?.encodeToJson(), encoding: JSONEncoding.default)
                .validate(statusCode: 200..<401)
                .response(completionHandler: { response in
                    switch response.result {
                    case .success(_):
                        do {
                            let decodedResponse = try JSONDecoder().decode(BaseResponse<T>.self, from: response.data ?? Data())
                            let state = NetworkState<T>(decodedResponse)
                            continuation.resume(returning: state)
                        } catch {
                            debugPrint("❌❌❌ Model \(String(describing: T.self)) Has Decoding Error ❌❌❌: ->>>", error)
                            continuation.resume(returning: .fail(AppError.networkError))
                        }
                    case .failure(let error):
                        debugPrint("Model Name: \(String(describing: T.self)) has request error", error)
                        continuation.resume(returning: .fail(AppError.networkError))
                    }
                })
        }
        
        return Just(result)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
