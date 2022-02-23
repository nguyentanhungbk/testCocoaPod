//
//  UIView+Extension.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 22/02/2022.
//

import Foundation

public extension UIView {

    func createLineDashLayer(start: CGPoint,
                             end: CGPoint,
                             lineDashPattern: Bool = true,
                             width: CGFloat = 1.0,
                             color: CGColor = UIColor(named: "LightSeperatorColor")!.cgColor) -> CAShapeLayer {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        if lineDashPattern { caShapeLayer.lineDashPattern = [1, 2] }
        caShapeLayer.lineDashPhase = 10
        let cgPath = CGMutablePath()
        let cgPoint = [start, end]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        return caShapeLayer
    }

    /// This is the function to get subViews of a view of a particular type
    func subViews<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }

    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard !view.subviews.isEmpty else {
                return
            }
            view.subviews.forEach {
                getSubview(view: $0)
            }
        }
        getSubview(view: self)
        return all
    }

}
