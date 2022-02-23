//
//  UIColor+Ext.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 17/02/2022.
//

import Foundation

public extension UIColor {
    /// Init color with input is hex string.
    /// - Parameters:
    ///   - hexString: hex string of color.
    @objc convenience init?(hexString: String) {
        let alpha, red, green, blue: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString.suffix(from: start))

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0

                if scanner.scanHexInt32(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    blue = CGFloat((hexNumber & 0x0000ff)) / 255

                    self.init(red: red, green: green, blue: blue, alpha: 1.0)
                    return
                }
            } else if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0

                if scanner.scanHexInt32(&hexNumber) {
                    alpha = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    red = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    green = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    blue = CGFloat((hexNumber & 0x000000ff)) / 255

                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }

        return nil
    }

    /// Init color with input is hex number.
    /// - Parameters:
    ///   - hexNumber: hex number of color.
    @objc convenience init(hexNumber: Int) {
        let components = (
            R: CGFloat((hexNumber >> 16) & 0xff) / 255,
            G: CGFloat((hexNumber >> 08) & 0xff) / 255,
            B: CGFloat((hexNumber >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

    /// get lighter color with amout
    /// - Parameters:
    ///   - amount: number.
    func lighter(_ amount: CGFloat = 0.1) -> UIColor {
        return hueColorWithBrightnessAmount(1 + amount)
    }

    func darker(_ amount: CGFloat = 0.1) -> UIColor {
        return hueColorWithBrightnessAmount(1 - amount)
    }

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func hueColorWithBrightnessAmount(_ amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor( hue: hue,
                            saturation: saturation,
                            brightness: brightness * amount,
                            alpha: alpha )
        }

        return self
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage / 100, 1.0),
                           green: min(green + percentage / 100, 1.0),
                           blue: min(blue + percentage / 100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }

    /// Convert UIColor to hex string.
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0

        return NSString(format: "#%06x", rgb) as String
    }
}
