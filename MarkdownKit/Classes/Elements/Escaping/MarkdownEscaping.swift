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
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }

  public func match(match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let range = NSRange(location: match.range.location + 1, length: 1)
    // escape one character
    let matchString = attributedString.attributedSubstring(from: range).string
    if let escapedString = Array<UInt16>(matchString.utf16).first
      .flatMap({ (value: UInt16) -> String in String(format: "%04x", value) }) {
      attributedString.replaceCharacters(in: range, with: escapedString)
    }
  }

}
