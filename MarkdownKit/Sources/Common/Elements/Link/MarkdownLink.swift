//
//  MarkdownLink.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation
import OSLog

open class MarkdownLink: MarkdownLinkElement {

  fileprivate static let regex = "(\\[[^\\]]+)(\\]\\([^\\s]+)?\\)"

  private let schemeRegex = "([a-z]{2,20}):\\/\\/"

  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var defaultScheme: String?

  open var regex: String {
    return MarkdownLink.regex
  }

  open func regularExpression() throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: regex, options: .dotMatchesLineSeparators)
  }

  public init(font: MarkdownFont? = nil, color: MarkdownColor? = MarkdownLink.defaultColor) {
    self.font = font
    self.color = color
  }

  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, link: String) {
    let regex = try? NSRegularExpression(pattern: schemeRegex, options: .caseInsensitive)
    let hasScheme = regex?.firstMatch(
        in: link,
        options: .anchored,
        range: NSRange(0..<link.count)
    ) != nil

    let fullLink = hasScheme ? link : "\(defaultScheme ?? "https://")\(link)"

    guard let encodedLink = fullLink.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    guard let url = URL(string: fullLink) ?? URL(string: encodedLink) else { return }
    attributedString.addAttribute(NSAttributedString.Key.link, value: url, range: range)
  }

  open func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    // Remove opening bracket
    attributedString.deleteCharacters(in: NSRange(location: match.range(at: 1).location, length: 1))

    // Remove closing bracket
    attributedString.deleteCharacters(in: NSRange(location: match.range(at: 2).location - 1, length: 1))

    let urlStart = match.range(at: 2).location

    let string = NSString(string: attributedString.string)
    var urlString = String(string.substring(with: NSRange(urlStart..<match.range(at: 2).upperBound - 2 )))

    // Determine url bounds by balancing opening and closing paranthesis
    // Removes remaining extra closing parantheses
    let numberOfOpeningParentheses = urlString.numberOfOccurrences(of: "(")
    let numberOfClosingParentheses = urlString.numberOfOccurrences(of: ")")
    var numberOfExtraClosingParentheses = max(0, numberOfClosingParentheses - numberOfOpeningParentheses)

    while numberOfExtraClosingParentheses > 0 && urlString.hasSuffix(")") {
      numberOfExtraClosingParentheses -= 1
      urlString = String(urlString.dropLast())
    }

    // Remove opening parantheses
    attributedString.deleteCharacters(in: NSRange(location: match.range(at: 2).location  , length: 1))

    // Remove closing parantheses
    let trailingMarkdownRange = NSRange(location: match.range(at: 2).location - 1, length: urlString.count + 1)
    attributedString.deleteCharacters(in: trailingMarkdownRange)

    let formatRange = NSRange(match.range(at: 1).location..<match.range(at: 2).location - 1)
    formatText(attributedString, range: formatRange, link: urlString)
    addAttributes(attributedString, range: formatRange, link: urlString)
  }

  open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange, link: String) {
    attributedString.addAttributes(attributes, range: range)
  }
}

fileprivate extension String {
    func numberOfOccurrences(of string: String) -> Int {
        return max(0, components(separatedBy: string).count - 1)
    }
}
