//
//  URL+Ext.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 17/02/2022.
//

import Foundation

public extension URL {

    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else {
            return nil
        }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }

    func isValidUrl() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }

    var isDirectory: Bool {
        let values = try? resourceValues(forKeys: [.isDirectoryKey])
        return values?.isDirectory ?? false
    }
}
