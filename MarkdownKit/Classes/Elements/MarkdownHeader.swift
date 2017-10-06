//
//  MarkdownHeader.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownHeader: MarkdownLevelElement {
    public var attr: [String : Any]
    fileprivate static let regex = "^(#{1,%@})\\s*(.+)$"
    
    open var maxLevel: Int
    open var fontIncrease: Int
    
    open var regex: String {
        let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
        return String(format: MarkdownHeader.regex, level)
    }
    
    public init(dict:[String:Any], maxLevel: Int = 0, fontIncrease: Int = 0) {
        self.attr = dict
        self.maxLevel = maxLevel
        self.fontIncrease = fontIncrease
    }
    
    open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
        attributedString.deleteCharacters(in: range)
    }
    
    /*open func attributesForLevel(_ level: Int) -> [String: AnyObject] {
        var attributes = self.attributes
        attributes = self.attr as [String : AnyObject]
        return attributes
    }*/
}
