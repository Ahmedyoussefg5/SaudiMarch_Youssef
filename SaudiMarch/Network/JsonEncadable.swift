//
//  JsonEncadable.swift
//  Youssef
//
//  Created by Youssef on 7/14/22.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation

protocol JsonEncadable {
    func encodeToJson() -> [String: Any]
}

extension JsonEncadable {
    func encodeToJson() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictEncoded = [String: Any]()
        mirror.children.forEach { child in
            dictEncoded[child.label!] = child.value
        }
        
        return dictEncoded
    }
}
