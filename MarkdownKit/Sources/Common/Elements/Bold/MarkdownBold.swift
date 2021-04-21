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
    // deleting trailing markdown
    attributedString.deleteCharacters(in: match.range(at: 4))
    
    // formatting string (may alter the length)
    let stringAttributes = attributedString.attributes(at: match.range(at: 3).location, longestEffectiveRange: nil, in: match.range(at: 3))
    addAttributes(attributedString, range: match.range(at: 3))
    
    if let font = font,
      let stringFont = stringAttributes[.font] as? MarkdownFont {
      let fontSize: CGFloat = stringFont.fontDescriptor.pointSize
      let fontTraits = stringFont.fontDescriptor.symbolicTraits
      var boldFont: MarkdownFont = font.withSize(fontSize)
      boldFont = boldFont.withTraits(fontTraits, .traitBold) ?? boldFont
      attributedString.addAttributes([NSAttributedString.Key.font: boldFont], range: match.range(at: 3))
    }
    
    // deleting leading markdown
    attributedString.deleteCharacters(in: match.range(at: 2))
  }
}
