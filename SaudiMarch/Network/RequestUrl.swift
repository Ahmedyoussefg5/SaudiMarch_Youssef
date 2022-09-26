//
//  RequestUrl.swift
//  Youssef
//
//  Created by Youssef on 7/14/22.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation

enum RequestUrl {
    case full(String)
    case path(String)
    case urlPathParam(path: String)
    case queryUrl(query: JsonEncadable)
    
    var value: String {
        
        let baseUrl = Constants.baseUrl
        
        switch self {
        case .full(let url):
            return url
            
        case.path(let path):
            return baseUrl + path
            
        case .urlPathParam(let path):
            let fullUrl = "\(baseUrl)\(path)"
            return fullUrl
            
        case .queryUrl(let query):
            var fullUrl = "\(baseUrl)?"
            
            query.encodeToJson().forEach {
                // fullUrl += "&"
                fullUrl += "\($0.key)=\($0.value)&"
            }
            
            fullUrl = String(fullUrl.dropLast())
            // fullUrl = fullUrl.replacingOccurrences(of: "?&", with: "?")
            return fullUrl
        }
    }
}
