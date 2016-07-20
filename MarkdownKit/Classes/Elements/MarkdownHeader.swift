//
//  MarkdownHeader.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownHeader: MarkdownLevelElement {
  
  private static let regex = "^(#{1,%@})\\s*(.+)$"
  
  public var maxLevel: Int
  public var font: UIFont?
  public var color: UIColor?
  public var fontIncrease: Int
  
  public var regex: String {
    let level = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownHeader.regex, level)
  }
  
  public init(maxLevel: Int = 0,
              font: UIFont? = UIFont.boldSystemFontOfSize(UIFont.smallSystemFontSize()),
              fontIncrease: Int = 2, color: UIColor? = nil) {
    self.maxLevel = maxLevel
    self.font = font
    self.color = color
    self.fontIncrease = fontIncrease
  }
  
  public func formatText(attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
      attributedString.deleteCharactersInRange(range)
  }
  
  public func attributesForLevel(level: Int) -> [String: AnyObject] {
    var attributes = self.attributes
    if let font = font {
      let headerFontSize: CGFloat = font.pointSize + (CGFloat(level) * CGFloat(fontIncrease))
      attributes[NSFontAttributeName] = font.fontWithSize(headerFontSize)
    }
    return attributes
  }
}
