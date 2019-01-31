//
//  MarkdownLevelElement.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

/// MarkdownLevelElement serves the purpose of handling Elements which may have more than one 
/// representation (e.g. Headers or Lists)
public protocol MarkdownLevelElement: MarkdownElement, MarkdownStyle {
  
  /// The maximum level of elements we should parse (e.g. limit the headers to 6 #s)
  var maxLevel: Int { get }
  
  func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int)
  func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int)
    func attributesForLevel(_ level: Int) -> [NSAttributedString.Key: AnyObject]
}

public extension MarkdownLevelElement {
  
  
  func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .anchorsMatchLines)
  }
  
  func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    attributedString.addAttributes(attributesForLevel(level - 1), range: range)
  }
  
    func attributesForLevel(_ level: Int) -> [NSAttributedString.Key: AnyObject] {
    return self.attributes
  }
  
  func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let level = match.range(at: 1).length
    addAttributes(attributedString, range: match.range(at: 2), level: level)
    let range = NSRange(location: match.range(at: 1).location,
                        length: match.range(at: 2).location - match.range(at: 1).location)
    formatText(attributedString, range: range, level: level)
  }
}
