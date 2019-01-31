//
//  MarkdownElement.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
/// MarkdownCommentElement represent the default Markdown elements which only manipulate content 
/// visually, (e.g. Bold or Italic)
import Foundation

public protocol MarkdownCommonElement: MarkdownElement, MarkdownStyle {
  
  func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange)
}

public extension MarkdownCommonElement {
  
  func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: [])
  }
  
  func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange) {
    attributedString.addAttributes(attributes, range: range)
  }
  
  func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    // deleting trailing markdown
    attributedString.deleteCharacters(in: match.range(at: 4))
    // formatting string (may alter the length)
    addAttributes(attributedString, range: match.range(at: 3))
    // deleting leading markdown
    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
