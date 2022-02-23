//
//  NSAttributedString+Extension.swift
//  CommonExtension
//
//  Created by Hung Nguyen on 21/02/2022.
//

import Foundation
import UIKit

public extension NSAttributedString {

    func heightForAttributedString(width: CGFloat) -> CGFloat {

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let rectForAttributtedString = self.boundingRect(with: constraintRect,
                                                         options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                         context: nil)

        return ceil(rectForAttributtedString.size.height)
    }

    func heightForAttributedStringWithDefaultNumberOfLines(numberOfLines: Int, maxWidth: CGFloat, font: UIFont, textColor: UIColor) -> CGFloat {

        let constraintRect = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let contentHeight = self.boundingRect(with: constraintRect,
                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                              context: nil).size.height

        if numberOfLines == 0 {
            return ceil(contentHeight)
        }

        let minimumlineHeight = CGRect(x: 0,
                                       y: 0,
                                       width: maxWidth,
                                       height: self.heightForSingleLineAttributedString(width: maxWidth,
                                                                                        font: font,
                                                                                        textColor: textColor)).size.height

        let maximumContentHeight = minimumlineHeight * CGFloat(numberOfLines)
        if contentHeight > maximumContentHeight {
            return ceil(maximumContentHeight)
        }

        return ceil(contentHeight)
    }

    private func heightForSingleLineAttributedString(width: CGFloat, font: UIFont, textColor: UIColor) -> CGFloat {

        let singleLineAttributedString = "A".getAttributeString(font: font, textColor: textColor)
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let lineHeight = singleLineAttributedString.boundingRect(with: constraintRect,
                                          options: [.usesLineFragmentOrigin, .usesFontLeading],
                                          context: nil).size

        return ceil(lineHeight.height)
    }
}
