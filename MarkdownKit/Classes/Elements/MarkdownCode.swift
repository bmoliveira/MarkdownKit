//
//  MarkdownCode.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownCode: MarkdownCommonElement {
  
  private static let regex = "(`+)(\\s*.*?[^`]\\s*)(\\1)(?!`)"
  
  public var font: UIFont?
  public var color: UIColor?
  
  public var regex: String {
    return MarkdownCode.regex
  }
  
  public init(font: UIFont? = UIFont(name: "Courier New",size: UIFont.smallSystemFontSize()),
       color: UIColor? = nil) {
    self.font = font
    self.color = color
  }
  
  public func match(match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let matchString = attributedString.attributedSubstringFromRange(match.range).string
    guard let unescapedString = matchString.unescapeUTF16() else { return }
    attributedString.replaceCharactersInRange(match.range, withString: unescapedString)
    addAttributes(attributedString, range: match.range)
  }
}
