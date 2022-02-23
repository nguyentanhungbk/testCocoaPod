//
//  UIViewController+Extension.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 21/02/2022.
//

import Foundation

// swiftlint:disable identifier_name
public extension UIViewController {

    enum SizeClass {
        case unknown
        case wR_hR
        case wC_hC
        case wR_hC
        case wC_hR
    }

    // return system size class in "(width, height)" format
    func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
    }

    // return custom emum of size class
    func getSizeClass() -> SizeClass {
        switch self.sizeClass() {
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            return .wR_hR
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            return .wC_hC
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            return .wR_hC
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            return .wC_hR
        default:
            // UIUserInterfaceSizeClass.unspecified
            // Unknown width OR Unknown height
            return .unknown
        }
    }

    static var identifier: String {
        return String(describing: self)
    }

    var isPresentedController: Bool {

        let isViewControllerPresented = presentingViewController != nil
        let viewCtrl = navigationController?.presentingViewController?.presentedViewController
        let isNavigationControllerPresented = viewCtrl == navigationController
        let isTabBarControllerPresented = tabBarController?.presentingViewController is UITabBarController

        return isViewControllerPresented || isNavigationControllerPresented || isTabBarControllerPresented
    }
}
