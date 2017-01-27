//
//  MarkdownParser.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownParser {
  public struct EnabledElements: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }

    public static let automaticLink = EnabledElements(rawValue: 1)
    public static let header        = EnabledElements(rawValue: 1 << 1)
    public static let list          = EnabledElements(rawValue: 1 << 2)
    public static let quote         = EnabledElements(rawValue: 1 << 3)
    public static let link          = EnabledElements(rawValue: 1 << 4)
    public static let bold          = EnabledElements(rawValue: 1 << 5)
    public static let italic        = EnabledElements(rawValue: 1 << 6)
    public static let code          = EnabledElements(rawValue: 1 << 7)

    public static let disabledAutomaticLink: EnabledElements = [
      .header,
      .list,
      .quote,
      .link,
      .bold,
      .italic,
      .code,
      ]

    public static let all: EnabledElements = [
      .disabledAutomaticLink,
      .automaticLink,
      ]
  }


  // MARK: Element Arrays
  fileprivate var escapingElements: [MarkdownElement]
  fileprivate var defaultElements: [MarkdownElement] = []
  fileprivate var unescapingElements: [MarkdownElement]

  open var customElements: [MarkdownElement]

  // MARK: Basic Elements
  open let header: MarkdownHeader
  open let list: MarkdownList
  open let quote: MarkdownQuote
  open let link: MarkdownLink
  open let automaticLink: MarkdownAutomaticLink
  open let bold: MarkdownBold
  open let italic: MarkdownItalic
  open let code: MarkdownCode

  // MARK: Escaping Elements
  fileprivate var codeEscaping = MarkdownCodeEscaping()
  fileprivate var escaping = MarkdownEscaping()
  fileprivate var unescaping = MarkdownUnescaping()

  // MARK: Configuration
  /// Enables individual Markdown elements and automatic link detection
  open var enabledElements: EnabledElements {
    didSet {
      updateDefaultElements()
    }
  }
  open let font: UIFont

  // MARK: Initializer
  public init(font: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
              enabledElements: EnabledElements = .all,
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

    self.escapingElements = [codeEscaping, escaping]
    self.unescapingElements = [code, unescaping]
    self.customElements = customElements
    self.enabledElements = enabledElements
    updateDefaultElements()
  }

  // MARK: Element Extensibility
  open func addCustomElement(_ element: MarkdownElement) {
    customElements.append(element)
  }

  open func removeCustomElement(_ element: MarkdownElement) {
    guard let index = customElements.index(where: { someElement -> Bool in
      return element === someElement
    }) else {
      return
    }
    customElements.remove(at: index)
  }

  // MARK: Parsing
  open func parse(_ markdown: String) -> NSAttributedString {
    return parse(NSAttributedString(string: markdown))
  }

  open func parse(_ markdown: NSAttributedString) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(attributedString: markdown)
    attributedString.addAttribute(NSFontAttributeName, value: font,
                                  range: NSRange(location: 0, length: attributedString.length))
    var elements: [MarkdownElement] = escapingElements
    elements.append(contentsOf: defaultElements)
    elements.append(contentsOf: customElements)
    elements.append(contentsOf: unescapingElements)
    elements.forEach { element in
      element.parse(attributedString)
    }
    return attributedString
  }

  fileprivate func updateDefaultElements() {
    let pairs: [(EnabledElements, MarkdownElement)] = [
      (.automaticLink, automaticLink),
      (.header, header),
      (.list, list),
      (.quote, quote),
      (.link, link),
      (.bold, bold),
      (.italic, italic),
      (.code, code),
      ]
    defaultElements = pairs.filter({ (enabled, _) in
      enabledElements.contains(enabled) })
      .map({ (_, element) in
        element })
  }

}
