//
//  Collection+Extension.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 21/02/2022.
//

import Foundation

public extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }

    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

public extension Dictionary {

    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
}
