//
//  MarkdownEscaping.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownEscaping: MarkdownElement {

  fileprivate static let regex = "\\\\."

  open var regex: String {
    return MarkdownEscaping.regex
  }

  open func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }

  open func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let range = NSRange(location: match.range.location + 1, length: 1)
    // escape one character
    let matchString = attributedString.attributedSubstring(from: range).string
    if let escapedString = Array<UInt16>(matchString.utf16).first
      .flatMap({ (value: UInt16) -> String in String(format: "%04x", value) }) {
      attributedString.replaceCharacters(in: range, with: escapedString)
    }
  }

}
