import Foundation
import MarkdownKit

class MarkdownUnderline: MarkdownElement {
    internal let regex = "(<u>)(.+?)(</u>)"

  let font: MarkdownFont?
  let color: MarkdownColor?
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font
    self.color = color
  }

  public func regularExpression() throws -> NSRegularExpression {
    try NSRegularExpression(pattern: regex)
  }

  public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    attributedString.deleteCharacters(in: match.range(at: 3))

    attributedString.addAttribute(
      NSAttributedString.Key.underlineStyle,
      value: NSNumber.init(value: NSUnderlineStyle.single.rawValue),
      range: match.range(at: 2)
    )
      attributedString.addAttribute(
        NSAttributedString.Key.underlineColor,
        value: color ?? MarkdownColor.black,
        range: match.range(at: 2)
      )

    attributedString.deleteCharacters(in: match.range(at: 1))
  }
}
