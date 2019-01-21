//
//  MarkdownCode.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownCode: MarkdownCommonElement {

  fileprivate static let regex = "(.?|^)(\\`{1,3})(.+?)(\\2)"

  open var font: UIFont?
  open var color: UIColor?
  open var textHighlightColor: UIColor?
  open var textBackgroundColor: UIColor?

  open var regex: String {
    return MarkdownCode.regex
  }

  public init(font: UIFont? = UIFont(name: "Menlo-Regular", size: 16),
              color: UIColor? = nil,
              textHighlightColor: UIColor? = UIColor(red: 0.90, green: 0.20, blue: 0.40, alpha: 1.0),
              textBackgroundColor: UIColor? = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)) {
    self.font = font
    self.color = color
    self.textHighlightColor = textHighlightColor
    self.textBackgroundColor = textBackgroundColor
  }

  open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange) {
    let matchString: String = attributedString.attributedSubstring(from: range).string
    guard let unescapedString = matchString.unescapeUTF16() else { return }
    attributedString.replaceCharacters(in: range, with: unescapedString)
    
    var codeAttributes = attributes
    
    textHighlightColor.flatMap { codeAttributes[NSAttributedString.Key.foregroundColor] = $0 }
    textBackgroundColor.flatMap { codeAttributes[NSAttributedString.Key.backgroundColor] = $0 }
    font.flatMap { codeAttributes[NSAttributedString.Key.font] = $0 }
    
    let updatedRange = (attributedString.string as NSString).range(of: unescapedString)
    attributedString.addAttributes(codeAttributes, range: NSRange(location: range.location, length: updatedRange.length))
  }
}
