//
//  AppError.swift
//  Youssef
//
//  Created by Youssef on 16/12/2021.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    
    case networkError
    case businessError(String)
    
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return Constants.Error.networkErrorMessage
        case .businessError( let error):
            return error
        }
    }
}
