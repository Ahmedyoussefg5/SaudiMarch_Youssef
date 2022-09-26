//
//  ScreenState.swift
//  SaudiMarch
//
//  Created by MacBook pro on 21/09/2022.
//

import Foundation

enum ScreenState<T>: Equatable {
    static func == (lhs: ScreenState<T>, rhs: ScreenState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.ideal, .ideal):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
    
    case ideal
    case loading
    case success(T)
    case failure(String)
    
    var data: T? {
        switch self {
        case .success(let value):
            return value
        default: return nil
        }
    }
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        } else {
            return false
        }
    }
}
