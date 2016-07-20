//
//  MarkdownLevelElement.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

/// MarkdownLevelElement serves the purpose of handling Elements which may have more than one 
/// representation (e.g. Headers or Lists)
public protocol MarkdownLevelElement: MarkdownElement, MarkdownStyle {
  
  /// The maximum level of elements we should parse (e.g. limit the headers to 6 #s)
  var maxLevel: Int { get }
  
  func formatText(attributedString: NSMutableAttributedString, range: NSRange, level: Int)
  func addAttributes(attributedString: NSMutableAttributedString, range: NSRange, level: Int)
  func attributesForLevel(level: Int) -> [String: AnyObject]
}

public extension MarkdownLevelElement {
  
  
  func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .AnchorsMatchLines)
  }
  
  func addAttributes(attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    attributedString.addAttributes(attributesForLevel(level - 1), range: range)
  }
  
  func attributesForLevel(level: Int) -> [String: AnyObject] {
    return self.attributes
  }
  
  func match(match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let level = match.rangeAtIndex(1).length
    addAttributes(attributedString, range: match.rangeAtIndex(2), level: level)
    let range = NSRange(location: match.rangeAtIndex(1).location,
                        length: match.rangeAtIndex(2).location - match.rangeAtIndex(1).location)
    formatText(attributedString, range: range, level: level)
  }
}
