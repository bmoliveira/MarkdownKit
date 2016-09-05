//
//  MarkdownUnescaping.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownUnescaping: MarkdownElement {
  
  private static let regex = "\\\\[0-9a-z]{4}"
  
  public var regex: String {
    return MarkdownUnescaping.regex
  }
  
  public func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }
  
  public func match(match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let range = NSRange(location: match.range.location + 1, length: 4)
    let matchString = attributedString.attributedSubstring(from: range).string
    guard let unescapedString = matchString.unescapeUTF16() else { return }
    attributedString.replaceCharacters(in: match.range, with: unescapedString)
  }
}
