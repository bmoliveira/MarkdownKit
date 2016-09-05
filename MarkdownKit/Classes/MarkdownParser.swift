//
//  MarkdownParser.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownParser {

  // MARK: Element Arrays
  private var escapingElements: [MarkdownElement]
  private var defaultElements: [MarkdownElement]
  private var unescapingElements: [MarkdownElement]

  public var customElements: [MarkdownElement]

  // MARK: Basic Elements
  public let header: MarkdownHeader
  public let list: MarkdownList
  public let quote: MarkdownQuote
  public let link: MarkdownLink
  public let automaticLink: MarkdownAutomaticLink
  public let bold: MarkdownBold
  public let italic: MarkdownItalic
  public let code: MarkdownCode

  // MARK: Escaping Elements
  private var codeEscaping = MarkdownCodeEscaping()
  private var escaping = MarkdownEscaping()
  private var unescaping = MarkdownUnescaping()

  // MARK: Configuration
  /// Enables or disables detection of URLs even without Markdown format
  public var automaticLinkDetectionEnabled: Bool = true
  public let font: UIFont

  // MARK: Initializer
  public init(font: UIFont = UIFont.systemFontOfSize(UIFont.smallSystemFontSize()),
              automaticLinkDetectionEnabled: Bool = true,
              customElements: [MarkdownElement] = []) {
    self.font = font

    header = MarkdownHeader(font: font)
    list = MarkdownList(font: font)
    quote = MarkdownQuote(font: font)
    link = MarkdownLink(font: font)
    automaticLink = MarkdownAutomaticLink(font: font)
    bold = MarkdownBold(font: font)
    italic = MarkdownItalic(font: font)
    code = MarkdownCode(font: font)

    self.automaticLinkDetectionEnabled = automaticLinkDetectionEnabled
    self.escapingElements = [codeEscaping, escaping]
    self.defaultElements = [header, list, quote, link, automaticLink, bold, italic]
    self.unescapingElements = [code, unescaping]
    self.customElements = customElements
  }

  // MARK: Element Extensibility
  public func addCustomElement(element: MarkdownElement) {
    customElements.append(element)
  }

  public func removeCustomElement(element: MarkdownElement) {
    guard let index = customElements.indexOf({ someElement -> Bool in
      return element === someElement
    }) else {
      return
    }
    customElements.removeAtIndex(index)
  }

  // MARK: Parsing
  public func parse(markdown: String) -> NSAttributedString {
    return parse(NSAttributedString(string: markdown))
  }

  public func parse(markdown: NSAttributedString) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(attributedString: markdown)
    attributedString.addAttribute(NSFontAttributeName, value: font,
                                  range: NSRange(location: 0, length: attributedString.length))
    var elements: [MarkdownElement] = escapingElements
    elements.appendContentsOf(defaultElements)
    elements.appendContentsOf(customElements)
    elements.appendContentsOf(unescapingElements)
    elements.forEach { element in
      if automaticLinkDetectionEnabled || element.dynamicType != MarkdownAutomaticLink.self {
        element.parse(attributedString)
      }
    }
    return attributedString
  }

}
