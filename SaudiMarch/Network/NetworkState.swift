//
//  NetworkState.swift
//  Youssef
//
//  Created by Youssef on 7/14/22.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation

enum NetworkState<R: Codable> {
    case success(R?)
    case fail(AppError)
    
    var data: R? {
        switch self {
            case .success(let data):
                return data
            default: return nil
        }
    }
    
    var error: Error? {
        switch self {
            case .fail(let error):
                return error
            default: return nil
        }
    }
    
    var isSuccess: Bool {
        return data != nil
    }
    
    init(_ response: BaseResponse<R>) {
        if response.isSuccess {
            self = .success(response.data)
        } else if let error = response.errors?.first {
            self = .fail(AppError.businessError(error))
        } else {
            self = .fail(AppError.networkError)
        }
    }
    
    func toScreenState() -> ScreenState<R> {
        switch self {
        case .success(let data):
            if let data {
                return .success(data)
            } else {
                return .failure(AppError.networkError.localizedDescription)
            }
        case .fail(let error):
            return .failure(error.localizedDescription)
        }
    }
}
