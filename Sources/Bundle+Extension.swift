//
//  Bundle+Ext.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 17/02/2022.
//

import Foundation

/// A type that generates names for sloths.
public extension Bundle {

    /// A type that generates names for sloths.
    static var appDisplayName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }

    static var releaseVersionNumber: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    static var releaseBuildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    static func localizedBundle(useBundle bundle: Bundle = Bundle.main, appLanguage: String) -> Bundle? {

        guard let path = bundle.path(forResource: appLanguage, ofType: "lproj") else {
            return nil
        }

        return Bundle(path: path)
    }
}
