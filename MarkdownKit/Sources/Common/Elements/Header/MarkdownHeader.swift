//
//  MarkdownHeader.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownHeader: MarkdownLevelElement {

  fileprivate static let regex = "^(#{1,%@})\\s*(.+)$"

  open var maxLevel: Int
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var fontIncrease: Int

  open var regex: String {
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownHeader.regex, level)
  }

  public init(font: MarkdownFont? = MarkdownHeader.defaultFont,
              maxLevel: Int = 0, fontIncrease: Int = 2, color: MarkdownColor? = nil) {
    self.maxLevel = maxLevel
    self.font = font
    self.color = color
    self.fontIncrease = fontIncrease
  }

  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
      attributedString.deleteCharacters(in: range)
  }

    open func attributesForLevel(_ level: Int) -> [NSAttributedString.Key: AnyObject] {
    var attributes = self.attributes
    if let font = font {
        let headerFontSize: CGFloat = font.pointSize + 4 + (-1 * CGFloat(level) * CGFloat(fontIncrease))
      
      attributes[NSAttributedString.Key.font] = font.withSize(headerFontSize).bold()
    }
    return attributes
  }
}
