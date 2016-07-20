//
//  MarkdownElement.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

/// MarkdownCommentElement represent the default Markdown elements which only manipulate content 
/// visually, (e.g. Bold or Italic)
public protocol MarkdownCommonElement: MarkdownElement, MarkdownStyle {
  
  func addAttributes(attributedString: NSMutableAttributedString, range: NSRange)
}

public extension MarkdownCommonElement {
  
  func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: [])
  }
  
  func addAttributes(attributedString: NSMutableAttributedString, range: NSRange) {
    attributedString.addAttributes(attributes, range: range)
  }
  
  func match(match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    // deleting trailing markdown
    attributedString.deleteCharactersInRange(match.rangeAtIndex(3))
    // formatting string (may alter the length)
    addAttributes(attributedString, range: match.rangeAtIndex(2))
    // deleting leading markdown
    attributedString.deleteCharactersInRange(match.rangeAtIndex(1))
  }
}