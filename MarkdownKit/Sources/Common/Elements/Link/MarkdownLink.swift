//
//  MarkdownLink.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownLink: MarkdownLinkElement {
  
  private struct Constants {
    
    /// The RFC 5322 official standard email regex
    ///
    /// Source: https://emailregex.com/
    static let emailRegex = "^(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
    static let emailScheme = "mailto:"
    static let httpScheme = "http://"
  }
  
  fileprivate static let regex = "\\[[^\\]]+\\]\\(\\S+(?=\\))\\)"
  
  // This regex is eager if does not count even trailing Parentheses.
  fileprivate static let onlyLinkRegex = "\\(\\S+(?=\\))\\)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
    
  /// If set to true, the parser will automatically add schemes to URLs that have none
  open var automaticURLSchemes: Bool = false
  
  open var regex: String {
    return MarkdownLink.regex
  }
  
  open func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = MarkdownLink.defaultColor, automaticURLSchemes: Bool = false) {
    self.font = font
    self.color = color
    self.automaticURLSchemes = automaticURLSchemes
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
    // Transformation: Adding an automatic URL scheme if the feature is enabled and the URL doesn't already have a scheme
    guard url.scheme == nil, automaticURLSchemes else {
      return url
    }
    
    let urlString = url.absoluteString
    return URL(string: (isEmailAddress(urlString) ? Constants.emailScheme : Constants.httpScheme) + urlString)
  }
  
  private func isEmailAddress(_ string: String) -> Bool {
    return string.range(of: Constants.emailRegex, options: .regularExpression) != nil
  }
}
