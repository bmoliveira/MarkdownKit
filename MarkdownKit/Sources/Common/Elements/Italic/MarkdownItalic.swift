//
//  MarkdownItalic.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownItalic: MarkdownCommonElement {
  
  fileprivate static let regex = "(.?|^)(\\*|_)(?=\\S)(.+?)(?<![\\*_\\s])(\\2)"

  open var font: MarkdownFont?
  open var color: MarkdownColor?
  
  open var regex: String {
    return MarkdownItalic.regex
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font
    self.color = color
  }
    
  public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    attributedString.deleteCharacters(in: match.range(at: 4))

    attributedString.enumerateAttribute(.font, in: match.range(at: 3)) { value, range, stop in
      guard let font = value as? MarkdownFont else { return }
      if let customFont = self.font {
        self.font = font.isBold() ? customFont.bold().italic() : customFont.italic()
      } else {
        attributedString.addAttribute(
          NSAttributedString.Key.font,
          value: font.italic(),
          range: range
        )
      }
    }

    addAttributes(attributedString, range: match.range(at: 3))

    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
