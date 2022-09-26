//
//  AppRequestInterceptor.swift
//  Youssef
//
//  Created by Youssef on 7/14/22.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation
import Alamofire

class AppRequestInterceptor: RequestInterceptor {
    
    // [Request url: Number of times retried]
    private var retriedRequests: [String: Int] = [:]
    
    private var shouldRetryCount = 5
    private let retryDelay: TimeInterval = 2
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("ar", forHTTPHeaderField: "lang")
        urlRequest.setValue("os", forHTTPHeaderField: "ios")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //        if let token = AuthService.instance.authToken {
        //            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //        }
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let url = request.request?.url?.absoluteString else {
            removeCachedUrlRequest(url: request.request?.url?.absoluteString)
            completion(.doNotRetry) // don't retry
            return
        }
        
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        // request.retryCount // use it in futre
                
        if statusCode == 401, !url.contains("refreshTokenUrl") { // token in expired
           // TokenRefresherRequestHandler.shared.refreshPassportToken()
        }
        
        guard let retryCount = retriedRequests[url] else {
            /// for first retry
            retriedRequests[url] = 1
            completion(.retryWithDelay(retryDelay)) // retry after 1 second
            return
        }
        
        if retryCount <= shouldRetryCount {
            retriedRequests[url] = retryCount + 1
            completion(.retryWithDelay(retryDelay)) // retry after 1 second
        } else {
            removeCachedUrlRequest(url: url)
            completion(.doNotRetry) // don't retry
        }
    }
    
    private func removeCachedUrlRequest(url: String?) {
        guard let url = url else { return }
        retriedRequests.removeValue(forKey: url)
    }
}
