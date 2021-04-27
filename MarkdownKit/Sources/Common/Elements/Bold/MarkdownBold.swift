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

    let currentAttributes = attributedString.attributes(
      at: match.range(at: 3).location,
      longestEffectiveRange: nil,
      in: match.range(at: 3)
    )

    addAttributes(attributedString, range: match.range(at: 3))

    if let font = currentAttributes[.font] as? MarkdownFont {
      attributedString.addAttribute(
        NSAttributedString.Key.font,
        value: font.bold(),
        range: match.range(at: 3)
      )
    }

    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
