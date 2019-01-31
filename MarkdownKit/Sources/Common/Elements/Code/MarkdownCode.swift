//
//  MarkdownCode.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownCode: MarkdownCommonElement {

  fileprivate static let regex = "(.?|^)(\\`{1,3})(.+?)(\\2)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var textHighlightColor: MarkdownColor?
  open var textBackgroundColor: MarkdownColor?

  open var regex: String {
    return MarkdownCode.regex
  }

  public init(font: MarkdownFont? = MarkdownCode.defaultFont,
              color: MarkdownColor? = nil,
              textHighlightColor: MarkdownColor? = MarkdownCode.defaultHighlightColor,
              textBackgroundColor: MarkdownColor? = MarkdownCode.defaultBackgroundColor) {
    self.font = font
    self.color = color
    self.textHighlightColor = textHighlightColor
    self.textBackgroundColor = textBackgroundColor
  }

  open func addAttributes(_ attributedString: NSMutableAttributedString, range: NSRange) {
    let matchString: String = attributedString.attributedSubstring(from: range).string
    guard let unescapedString = matchString.unescapeUTF16() else { return }
    attributedString.replaceCharacters(in: range, with: unescapedString)
    
    var codeAttributes = attributes
    
    textHighlightColor.flatMap { codeAttributes[NSAttributedString.Key.foregroundColor] = $0 }
    textBackgroundColor.flatMap { codeAttributes[NSAttributedString.Key.backgroundColor] = $0 }
    font.flatMap { codeAttributes[NSAttributedString.Key.font] = $0 }
    
    let updatedRange = (attributedString.string as NSString).range(of: unescapedString)
    attributedString.addAttributes(codeAttributes, range: NSRange(location: range.location, length: updatedRange.length))
  }
}
