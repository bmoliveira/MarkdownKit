//
//  MarkdownBold.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownBold: MarkdownCommonElement {
  
  fileprivate static let regex = "(.?|^)(\\*\\*|__)(?=\\S)(.+?)(?<=\\S)(\\2)"

  open var font: MarkdownFont?
  open var color: MarkdownColor?
  
  open var regex: String {
    return MarkdownBold.regex
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font?.bold()
    self.color = color
  }
  
  public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    attributedString.deleteCharacters(in: match.range(at: 4))

    var attributes = attributedString.attributes(
        at: match.range(at: 3).location,
        longestEffectiveRange: nil,
        in: match.range(at: 3)
    )

    if let font = attributes[.font] as? MarkdownFont {
        attributes[NSAttributedString.Key.font] = font.bold()
    }

    attributedString.addAttributes(attributes, range: match.range(at: 3))

    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
