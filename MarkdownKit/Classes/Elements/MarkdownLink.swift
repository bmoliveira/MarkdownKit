//
//  MarkdownLink.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownLink: MarkdownLinkElement {

  public var attr: [String : Any]
  fileprivate static let regex = "\\[[^\\[]*?\\]\\([^\\)]*\\)"
  
  open var regex: String {
    return MarkdownLink.regex
  }
  
  open func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }
  
    public init(dict: [String: Any]) {
        attr = dict
    }
  
  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange,
                         link: String) {
    guard let encodedLink = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
      else {
      return
    }
    guard let url = URL(string: link) ?? URL(string: encodedLink) else { return }
    attributedString.addAttribute(NSLinkAttributeName, value: url, range: range)
    attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleNone.rawValue, range: range)
    attributedString.addAttribute(NSUnderlineColorAttributeName, value: UIColor.clear, range:range)
  }
  
  open func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let nsString = attributedString.string as NSString
    let linkStartInResult = nsString
      .range(of: "(", options: .backwards, range: match.range).location
    let linkRange =
      NSRange(location: linkStartInResult,
              length: match.range.length + match.range.location - linkStartInResult - 1)
    let linkURLString = nsString
      .substring(with: NSRange(location: linkRange.location + 1, length: linkRange.length - 1))
    
    // deleting trailing markdown
    // needs to be called before formattingBlock to support modification of length
    attributedString.deleteCharacters(in: NSRange(location: linkRange.location - 1,
      length: linkRange.length + 2))
    
    // deleting leading markdown
    // needs to be called before formattingBlock to provide a stable range
    attributedString.deleteCharacters(in: NSRange(location: match.range.location, length: 1))
    let formatRange = NSRange(location: match.range.location,
                              length: linkStartInResult - match.range.location - 2)
    formatText(attributedString, range: formatRange, link: linkURLString)
    addAttributes(attributedString, range: formatRange, link: linkURLString)
    attributedString.removeAttribute(NSUnderlineStyleAttributeName, range: NSMakeRange(0, attributedString.length))
  }
  
  open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange,
                            link: String) {attributedString.addAttributes(attr, range: range)}
}

