//
//  MarkdownBold.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownBold: MarkdownCommonElement {
    public var attr: [String : Any]
    
    fileprivate static let regex = "(\\s+|^)(\\*\\*|__)(.+?)(\\2)"
  
    open var regex: String {
        return MarkdownBold.regex
    }
  
    public init(dict: [String: Any]) {
        attr = dict
    }
    
    /*open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange) {
        let matchString: String = attributedString.attributedSubstring(from: range).string
        attributedString.addAttributes(attr, range: NSRange(location: range.location, length: matchString.characters.count))
    }*/
}
