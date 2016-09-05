//
//  MarkdownAutomaticLink.swift
//  Pods
//
//  Created by Ivan Bruel on 19/07/16.
//
//

import Foundation

public class MarkdownAutomaticLink: MarkdownLink {
  
 public override func regularExpression() throws -> NSRegularExpression {
    return try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
  }
  
  public override func match(match: NSTextCheckingResult,
                             attributedString: NSMutableAttributedString) {
    let linkURLString = attributedString.attributedSubstring(from: match.range).string
    formatText(attributedString: attributedString, range: match.range, link: linkURLString)
    addAttributes(attributedString: attributedString, range: match.range, link: linkURLString)
  }
}
