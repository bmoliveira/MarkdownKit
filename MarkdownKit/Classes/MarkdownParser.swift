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
  public var header = MarkdownHeader()
  public var list = MarkdownList()
  public var quote = MarkdownQuote()
  public var link = MarkdownLink()
  public var automaticLink = MarkdownAutomaticLink()
  public var bold = MarkdownBold()
  public var italic = MarkdownItalic()
  public var code = MarkdownCode()
  
  // MARK: Escaping Elements
  private var codeEscaping = MarkdownCodeEscaping()
  private var escaping = MarkdownEscaping()
  private var unescaping = MarkdownUnescaping()
  
  // MARK: Configuration
  public var automaticLinkDetectionEnabled: Bool = true

  // MARK: Initializer
  public init(automaticLinkDetectionEnabled: Bool = true, customElements: [MarkdownElement] = []) {
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
    (escapingElements + defaultElements + customElements + unescapingElements).forEach { element in
      if automaticLinkDetectionEnabled || element.dynamicType != MarkdownAutomaticLink.self {
        element.parse(attributedString)
      }
    }
    return attributedString
  }
  
}