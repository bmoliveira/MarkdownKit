//
//  MarkdownParser.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownParser {
  
  public var elements: [MarkdownElement]
  public var header = MarkdownHeader()
  public var list = MarkdownList()
  public var quote = MarkdownQuote()
  public var link = MarkdownLink()
  public var automaticLink = MarkdownAutomaticLink()
  public var bold = MarkdownBold()
  public var italic = MarkdownItalic()
  public var code = MarkdownCode()
  private var codeEscaping = MarkdownCodeEscaping()
  private var escaping = MarkdownEscaping()
  private var unescaping = MarkdownUnescaping()
  
  public init(customElements: [MarkdownElement] = []) {
    let defaultElements: [MarkdownElement] = [codeEscaping, escaping, header, list, quote, link,
                                              automaticLink, bold, italic, code, unescaping]
    self.elements = defaultElements + customElements
  }
  
  public func parse(markdown: String) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: markdown)
    elements.forEach { element in
      element.parse(attributedString)
    }
    return attributedString
  }
  
}