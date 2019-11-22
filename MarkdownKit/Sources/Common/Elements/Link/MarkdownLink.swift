//
//  MarkdownLink.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownLink: MarkdownLinkElement {
  
  fileprivate static let regex = "\\[[^\\]]+\\]\\(\\S+(?=\\))\\)"
  
  // This regex is eager if does not count even trailing Parentheses.
  fileprivate static let onlyLinkRegex = "\\(\\S+(?=\\))\\)"
  
  private static let urlSchemeSuffix = "://"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var automaticURLScheme: String?
  
  open var regex: String {
    return MarkdownLink.regex
  }
  
  open func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = MarkdownLink.defaultColor, automaticURLScheme: String? = nil) {
    self.font = font
    self.color = color
    self.automaticURLScheme = automaticURLScheme
  }
  
  
  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange,
                         link: String) {
    guard let encodedLink = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
      else {
      return
    }
    guard let url = URL(string: link) ?? URL(string: encodedLink), let transformedURL = transformedURL(url) else { return }
    attributedString.addAttribute(NSAttributedString.Key.link, value: transformedURL, range: range)
  }
  
  open func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    let nsString = (attributedString.string as NSString)
    let urlString = nsString.substring(with: match.range)
    
    guard let onlyLinkRegex = try? NSRegularExpression(pattern: MarkdownLink.onlyLinkRegex, options: .dotMatchesLineSeparators) else {
      return
    }
    
    guard let linkMatch = onlyLinkRegex.firstMatch(in: urlString,
                     options: .withoutAnchoringBounds,
                     range: NSRange(location: 0, length: urlString.count)) else {
                      return
    }

    let urlLinkAbsoluteStart = match.range.location
    
    let linkURLString = nsString
      .substring(with: NSRange(location: urlLinkAbsoluteStart + linkMatch.range.location + 1, length: linkMatch.range.length - 2))
    
    // deleting trailing markdown
    // needs to be called before formattingBlock to support modification of length
    let trailingMarkdownRange = NSRange(location: urlLinkAbsoluteStart + linkMatch.range.location - 1, length: linkMatch.range.length + 1)
    attributedString.deleteCharacters(in: trailingMarkdownRange)
    
    // deleting leading markdown
    // needs to be called before formattingBlock to provide a stable range
    let leadingMarkdownRange = NSRange(location: match.range.location, length: 1)
    attributedString.deleteCharacters(in: leadingMarkdownRange)
    
    let formatRange = NSRange(location: match.range.location,
                              length: linkMatch.range.location - 2)
    
    formatText(attributedString, range: formatRange, link: linkURLString)
    addAttributes(attributedString, range: formatRange, link: linkURLString)
  }
  
  open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange,
                            link: String) {
    attributedString.addAttributes(attributes, range: range)
  }
  
  /// - Returns: A transformed version of the given `URL`
  private func transformedURL(_ url: URL) -> URL? {
    // Transformation: Adding an automatic URL scheme if one is configured and the URL doesn't already have a scheme
    guard url.scheme == nil, let automaticURLScheme = self.automaticURLScheme else {
      return url
    }
    
    return URL(string: automaticURLScheme + MarkdownLink.urlSchemeSuffix + url.absoluteString)
  }
}
