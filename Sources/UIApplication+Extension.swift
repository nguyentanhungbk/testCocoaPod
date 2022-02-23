//
//  UIApplication+Ext.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 17/02/2022.
//

import UIKit

public extension UIApplication {
    
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// get top most view controller.
    /// - Parameters:
    ///   - controller: root view controller.
    class func getTopViewController(controller: UIViewController?) -> UIViewController? {

        guard controller != nil else {
            return nil
        }

        if let navigationController = controller as? UINavigationController {

            return getTopViewController(controller: navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {

            if let selected = tabController.selectedViewController {

                return getTopViewController(controller: selected)
            }
        }

        if let presented = controller?.presentedViewController {

            return getTopViewController(controller: presented)
        }

        return controller
    }
}
