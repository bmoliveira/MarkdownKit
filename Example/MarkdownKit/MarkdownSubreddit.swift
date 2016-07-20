//
//  MarkdownSubreddit.swift
//  MarkdownKit
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import MarkdownKit

class MarkdownSubreddit: MarkdownLink {
  
  private static let regex = "(^|\\s|\\W)(/?r/(\\w+)/?)"
  
  override var regex: String {
    return MarkdownSubreddit.regex
  }
  
  override func match(match: NSTextCheckingResult,
                             attributedString: NSMutableAttributedString) {
    let subredditName = attributedString.attributedSubstringFromRange(match.rangeAtIndex(3)).string
    let linkURLString = "http://reddit.com/r/\(subredditName)"
    formatText(attributedString, range: match.range, link: linkURLString)
    addAttributes(attributedString, range: match.range, link: linkURLString)
  }
  
}