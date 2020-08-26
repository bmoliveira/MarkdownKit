//
//  MarkdownStrikethrough.swift
//  Pods
//
//  Created by _ on _.
//
//
import Foundation

open class MarkdownStrikethrough: MarkdownCommonElement {
  fileprivate static let regex = "(.?|^)(\\~\\~|__)(?=\\S)(.+?)(?<=\\S)(\\2)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  public var attributes: [NSAttributedString.Key : AnyObject] = [ .strikethroughStyle: NSNumber.init(value: NSUnderlineStyle.single.rawValue) ]
  
  open var regex: String {
    return MarkdownStrikethrough.regex
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font
    self.color = color
  }
}
