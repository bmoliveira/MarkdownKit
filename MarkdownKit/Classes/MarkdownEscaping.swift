//
//  MarkdownEscaping.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownEscaping: MarkdownElement {
  
  private static let regex = "\\\\."
  
  public var regex: String {
    return MarkdownEscaping.regex
  }
  
  public func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .DotMatchesLineSeparators)
  }
  
  public func match(match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let range = NSRange(location: match.range.location + 1, length: 1)
    // escape one character
    let matchString = attributedString.attributedSubstringFromRange(range).string
    if let escapedString = Array(matchString.utf16).first
      .flatMap({ String(format: "%04x", $0) }) {
      attributedString.replaceCharactersInRange(range, withString: escapedString)
    }
  }
  
}
