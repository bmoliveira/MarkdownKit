//
//  MarkdownStrikethrough.swift
//  Pods
//
//  Created by _ on _.
//
//
import Foundation

open class MarkdownStrikethrough: MarkdownCommonElement {
  fileprivate static let regex = "(.?|^)(\\~\\~)(?=\\S)(.+?)(?<=\\S)(\\2)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  
  open var regex: String {
    return MarkdownStrikethrough.regex
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font
    self.color = color
  }

  public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    attributedString.deleteCharacters(in: match.range(at: 4))

    var attributes = attributedString.attributes(
      at: match.range(at: 3).location,
      longestEffectiveRange: nil,
      in: match.range(at: 3)
    )

    attributes[NSAttributedString.Key.strikethroughStyle] = NSNumber.init(value: NSUnderlineStyle.single.rawValue)

    attributedString.addAttributes(attributes, range: match.range(at: 3))

    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
