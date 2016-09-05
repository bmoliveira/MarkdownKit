//
//  MarkdownCode.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownCode: MarkdownCommonElement {

  private static let regex = "(\\s+|^)(`+)(\\s*.*?[^`]\\s*)(\\1)(?!`)"

  public var font: UIFont?
  public var color: UIColor?

  public var regex: String {
    return MarkdownCode.regex
  }

  public init(font: UIFont? = UIFont(name: "Courier New",size: UIFont.smallSystemFontSize),
              color: UIColor? = nil) {
    self.font = font
    self.color = color
  }

  public func addAttributes(attributedString: NSMutableAttributedString, range: NSRange) {
    let matchString: String = attributedString.attributedSubstring(from: range).string
    guard let unescapedString = matchString.unescapeUTF16() else { return }
    attributedString.replaceCharacters(in: range, with: unescapedString)
    attributedString.addAttributes(attributes, range: NSRange(location: range.location, length: unescapedString.characters.count))
  }
}
