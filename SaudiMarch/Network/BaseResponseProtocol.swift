//
//  BaseResponseProtocol.swift
//  Youssef
//
//  Created by Youssef on 16/12/2021.
//  Copyright © 2021 Youssef. All rights reserved.
//


import Foundation

public protocol BaseResponseProtocol: Codable {
    associatedtype NetworkModel: Codable
    var data: NetworkModel? { get set }
    var status: Status? { get set }
    var errors: [String]? { get set }
}

extension BaseResponseProtocol {
    public var isSuccess: Bool {
        return (status?.code == 200) && (errors == nil)
    }
    
//    func toNetworkState() -> NetworkState<NetworkModel> {
//        if isSuccess {
//            return .success(data)
//        } else {
//            let error = errors?.first ?? AppError.networkError.errorDescription ?? "Constants.error.networkErrorMessage"
//            return .fail(AppError.businessError(error))
//        }
//    }
}

// MARK: Base response
public struct BaseResponse<T: Codable>: BaseResponseProtocol {
    public typealias NetworkModel = T
    public var status: Status?
    public var data: T?
    public var errors: [String]?
    
    // MARK: For Testing
    public init(status: Status?, data: T?, errors: [String]?) {
        self.status = status
        self.data = data
        self.errors = errors
    }
    
    func getData() throws -> T {
          if let data = data {
              return data
          } else {
              throw EmptyDataError()
          }
      }
}

struct EmptyDataError: Error {
    
}

public struct EmptyData: Codable {
    
}

// MARK: - Status
public struct Status: Codable {
    public let code: Int
    public let message: String
}

enum UnknownType<F: Codable, S: Codable>: Codable {
    
    case firstValue(F)
    case secoundValue(S)
    
    var value: String? {
        switch self {
            case .firstValue(let val):
                return getValue(val)
            case .secoundValue(let val):
                return getValue(val)
        }
    }
    
    private func getValue(_ val: Any) -> String? {
        if let stringValue = val as? String {
            return stringValue
        } else if let intValue = val as? Int {
            return "\(intValue)"
        } else if val is Swift.Array<Swift.String> {
            let firstValue = (val as? [Any])?.first
            return "\(firstValue ?? "Error Found")"
        } else {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(F.self) {
            self = .firstValue(value)
            return
        }
        if let value = try? container.decode(S.self) {
            self = .secoundValue(value)
            return
        }
        throw DecodingError.typeMismatch(UnknownType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .secoundValue(let x):
                try container.encode(x)
            case .firstValue(let x):
                try container.encode(x)
        }
    }
}
