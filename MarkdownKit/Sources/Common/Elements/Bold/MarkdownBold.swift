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

    attributedString.enumerateAttribute(.font, in: match.range(at: 3)) { value, range, stop in
      if let font = value as? MarkdownFont {
        attributedString.addAttribute(
          NSAttributedString.Key.font,
          value: font.bold(),
          range: range
        )
      }
    }

    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
