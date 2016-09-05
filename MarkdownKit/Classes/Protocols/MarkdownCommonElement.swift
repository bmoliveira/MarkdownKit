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
    attributedString.deleteCharacters(in: match.rangeAt(4))
    // formatting string (may alter the length)
    addAttributes(attributedString: attributedString, range: match.rangeAt(3))
    // deleting leading markdown
    attributedString.deleteCharacters(in: match.rangeAt(2))
  }
}
