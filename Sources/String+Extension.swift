//
//  String+Ext.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 17/02/2022.
//

import UIKit

public extension String {
    var isValidEmailAddress: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }

    func htmlStringToDecodedPlainString() -> String {
        let output = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        guard let data = output.data(using: .utf8) else {
            return ""
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return ""
        }

        return attributedString.string
    }

    /// Validate whether the string is valid URL or not.
    func isValidURL() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }

    /// Convert string into the URL.
    func getURL() -> URL? {
        if self.isValidURL(), let url = URL(string: self) {
            return url
        }
        return nil
    }

    func height(_ width: CGFloat, font: UIFont, numberOfLines: Int, lineSpacing: CGFloat = 3.4, paragraphSpacing: CGFloat = 10) -> CGFloat {

        // Incase of an empty string
        if self.isEmpty {
            return 0.0
        }

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        // Height of label for the given string
        var height: CGFloat = 0.0
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing

        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle

        let heightOfTheText = ceil(self.boundingRect(with: constraintRect,
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: attributes,
                                                     context: nil).height)

        if numberOfLines > 0 {
            // Height of a single line
            let singleLineHeight = self.heightForSingleLine(width, attributes: attributes)

            // If maximum number of lines are provided
            let maximumHeightOfGivenLines = singleLineHeight * CGFloat(numberOfLines)

            if heightOfTheText > maximumHeightOfGivenLines {
                height = singleLineHeight * CGFloat(numberOfLines)
            } else {
                height = heightOfTheText
            }
        } else {
            height = heightOfTheText
        }

        return height
    }

    func height(_ width: CGFloat, font: UIFont, numberOfLines: Int) -> CGFloat {

        // Incase of an empty string
        if self.isEmpty {
            return 0.0
        }

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        // Height of label for the given string
        var height: CGFloat = 0.0

        // Minimum height or height of a line
        let minimumHeight = CGRect(x: 0, y: 0, width: width, height: self.heightForLines(width, font: font, numberOfLines: 1))

        // Maximum height
        let maximumHeight = self.boundingRect(with: constraintRect,
                                              options: .usesLineFragmentOrigin,
                                              attributes: [NSAttributedString.Key.font: font],
                                              context: nil)

        if maximumHeight.height > minimumHeight.height {
            // If maximum number of lines are provided
            if numberOfLines > 0 {
                height = minimumHeight.height * CGFloat(numberOfLines)
            } else {
                height = maximumHeight.height
            }
        } else {
            height = minimumHeight.height
        }

        return ceil(height)
    }

    func heightForSingleLine(_ width: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        // Calculate the average height of single with paragraph spacing and line spacing.
        let lineHeight = "A\rA\rA".boundingRect(with: constraintRect,
                                                options: .usesLineFragmentOrigin,
                                                attributes: attributes,
                                                context: nil).height / 3

        return ceil(lineHeight)
    }

    func heightForLines(_ width: CGFloat, font: UIFont, numberOfLines: Int) -> CGFloat {

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        let lineHeight = "A".boundingRect(with: constraintRect,
                                          options: .usesLineFragmentOrigin,
                                          attributes: [NSAttributedString.Key.font: font],
                                          context: nil)

        return ceil(lineHeight.height * CGFloat(numberOfLines))
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude,
                                    height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)

        return ceil(boundingBox.width)
    }

    func getAttributeString(font: UIFont,
                            textColor: UIColor,
                            paragraphSpacing: CGFloat = 10,
                            paragraphAlignment: NSTextAlignment = .left,
                            lineHeight: CGFloat = 3.4,
                            truncateTail: Bool = false) -> NSAttributedString {

        if self.isEmpty {
            return NSAttributedString(string: "")
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.alignment = paragraphAlignment

        if truncateTail {
            paragraphStyle.lineBreakMode = .byTruncatingTail
        } else {
            paragraphStyle.lineBreakMode = .byWordWrapping
        }

        let attributedString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font,
                                                                                    NSAttributedString.Key.foregroundColor: textColor])
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }

    func attributedSubText(subString: String, attributed: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {

        let attributedString = NSMutableAttributedString(string: self)

        var range = NSRange(location: 0, length: attributedString.length)

        while range.location != NSNotFound {
            range = (attributedString.string.lowercased() as NSString).range(of: subString.lowercased(),
                                                                             options: [],
                                                                             range: range)
            if range.location != NSNotFound {
                for (key, value) in attributed {
                    attributedString.addAttribute(key,
                                                  value: value,
                                                  range: NSRange(location: range.location, length: subString.count))
                }
                range = NSRange(location: range.location + range.length,
                                length: attributedString.string.count - (range.location + range.length))
            }
        }
        return attributedString
    }

    func separatedBySpace() -> [String] {
        return self.components(separatedBy: " ")
    }
}
