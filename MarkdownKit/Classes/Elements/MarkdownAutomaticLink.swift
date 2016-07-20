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
    return try NSDataDetector(types: NSTextCheckingType.Link.rawValue)
  }
  
  public override func match(match: NSTextCheckingResult,
                             attributedString: NSMutableAttributedString) {
    let linkURLString = attributedString.attributedSubstringFromRange(match.range).string
    formatText(attributedString, range: match.range, link: linkURLString)
    addAttributes(attributedString, range: match.range, link: linkURLString)
  }
}