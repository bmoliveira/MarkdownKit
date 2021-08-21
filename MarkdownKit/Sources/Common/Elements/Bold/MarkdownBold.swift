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
    self.font = font
    self.color = color
  }

  public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    attributedString.deleteCharacters(in: match.range(at: 4))

    var attributes = self.attributes

    attributedString.enumerateAttribute(.font, in: match.range(at: 3)) { value, range, _ in
      guard let currentFont = value as? MarkdownFont else { return }
      if let customFont = self.font {
          attributes[.font] = currentFont.isItalic() ? customFont.bold().italic() : customFont.bold()
      } else {
        attributedString.addAttribute(
          NSAttributedString.Key.font,
          value: currentFont.bold(),
          range: range
        )
      }
    }

    attributedString.addAttributes(attributes, range: match.range(at: 3))

    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
