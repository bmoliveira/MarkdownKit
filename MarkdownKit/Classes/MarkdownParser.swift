//
//  MarkdownParser.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownParser {
    
    // MARK: Element Arrays
    fileprivate var escapingElements: [MarkdownElement]
    fileprivate var defaultElements: [MarkdownElement]
    fileprivate var unescapingElements: [MarkdownElement]
    
    open var customElements: [MarkdownElement]
    
    // MARK: Basic Elements
    open var header: MarkdownHeader
    open var link: MarkdownLink
    open var bold: MarkdownBold
    open var italic: MarkdownItalic
    
    //To-do: additional elements
    
    //open var list: MarkdownList
    //open var quote: MarkdownQuote
    //open var automaticLink: MarkdownAutomaticLink
    //open var code: MarkdownCode
    
    // MARK: Escaping Elements
    fileprivate var codeEscaping = MarkdownCodeEscaping()
    fileprivate var escaping = MarkdownEscaping()
    fileprivate var unescaping = MarkdownUnescaping()
    
    // MARK: Configuration
    /// Enables or disables detection of URLs even without Markdown format
    open var automaticLinkDetectionEnabled: Bool = true
    open let attr: [String:Any]
    
    // MARK: Initializer
    public init(dict: [String:Any],automaticLinkDetectionEnabled: Bool = true, customElements: [MarkdownElement] = []) {
        
        self.attr = dict[MarkdownType.base.rawValue] as! [String:Any]
        
        guard
            let headerStyle = dict[MarkdownType.header.rawValue] as? [String:Any],
            let linkStyle = dict[MarkdownType.link.rawValue] as? [String:Any],
            let boldStyle = dict[MarkdownType.bold.rawValue] as? [String:Any],
            let italicStyle = dict[MarkdownType.italic.rawValue] as? [String:Any]
        else {
            
            header = MarkdownHeader(dict: self.attr )
            link = MarkdownLink(dict: self.attr )
            bold = MarkdownBold(dict: self.attr )
            italic = MarkdownItalic(dict: self.attr )
            
            self.automaticLinkDetectionEnabled = automaticLinkDetectionEnabled
            self.escapingElements = [codeEscaping, escaping]
            self.defaultElements = [header,link,bold,italic]
            self.unescapingElements = [unescaping]
            self.customElements = customElements
            return
        }
        
        header = MarkdownHeader(dict: headerStyle )
        link = MarkdownLink(dict: linkStyle )
        bold = MarkdownBold(dict: boldStyle )
        italic = MarkdownItalic(dict: italicStyle )
        
        self.automaticLinkDetectionEnabled = automaticLinkDetectionEnabled
        self.escapingElements = [codeEscaping, escaping]
        self.defaultElements = [header,link,bold,italic]
        self.unescapingElements = [unescaping]
        self.customElements = customElements
        
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
        
        attributedString.addAttributes(self.attr, range: NSMakeRange(0, attributedString.length))
        
        var elements: [MarkdownElement] = escapingElements
        elements.append(contentsOf: defaultElements)
        elements.append(contentsOf: customElements)
        elements.append(contentsOf: unescapingElements)
        elements.forEach { element in
            if automaticLinkDetectionEnabled || type(of: element) != MarkdownAutomaticLink.self {
                element.parse(attributedString)
            }
        }
        return attributedString
    }
    
}

