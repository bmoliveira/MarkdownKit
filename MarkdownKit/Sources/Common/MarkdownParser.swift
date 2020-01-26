//
//  MarkdownParser.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

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
    public static let strikethrough = EnabledElements(rawValue: 1 << 8)

    public static let disabledAutomaticLink: EnabledElements = [
      .header,
      .list,
      .quote,
      .link,
      .bold,
      .italic,
      .code,
      .strikethrough,
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
  public let header: MarkdownHeader
  public let list: MarkdownList
  public let quote: MarkdownQuote
  public let link: MarkdownLink
  public let automaticLink: MarkdownAutomaticLink
  public let bold: MarkdownBold
  public let italic: MarkdownItalic
  public let code: MarkdownCode
  public let strikethrough: MarkdownStrikethrough
  
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

  public let font: MarkdownFont
  public let color: MarkdownColor
  
  // MARK: Legacy Initializer
  @available(*, deprecated, renamed: "init", message: "This constructor will be removed soon, please use the new opions constructor")
  public convenience init(automaticLinkDetectionEnabled: Bool,
                          font: MarkdownFont = MarkdownParser.defaultFont,
                          customElements: [MarkdownElement] = []) {
    let enabledElements: EnabledElements = automaticLinkDetectionEnabled ? .all : .disabledAutomaticLink
    self.init(font: font, enabledElements: enabledElements, customElements: customElements)
  }
  
  // MARK: Initializer
  public init(font: MarkdownFont = MarkdownParser.defaultFont,
              color: MarkdownColor = MarkdownParser.defaultColor,
              enabledElements: EnabledElements = .all,
              customElements: [MarkdownElement] = []) {
    self.font = font
    self.color = color
    
    header = MarkdownHeader(font: font)
    list = MarkdownList(font: font)
    quote = MarkdownQuote(font: font)
    link = MarkdownLink(font: font)
    automaticLink = MarkdownAutomaticLink(font: font)
    bold = MarkdownBold(font: font)
    italic = MarkdownItalic(font: font)
    code = MarkdownCode(font: font)
    strikethrough = MarkdownStrikethrough(font: font)

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
    guard let index = customElements.firstIndex(where: { someElement -> Bool in
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
    attributedString.addAttribute(.font, value: font,
                                  range: NSRange(location: 0, length: attributedString.length))
    attributedString.addAttribute(.foregroundColor, value: color,
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
      (.strikethrough, strikethrough),
      ]
    defaultElements = pairs.filter({ (enabled, _) in
      enabledElements.contains(enabled) })
      .map({ (_, element) in
        element })
  }
}
