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
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownHeader.regex, level)
  }

  public init(maxLevel: Int = 0,
              font: UIFont? = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),
              fontIncrease: Int = 2, color: UIColor? = nil) {
    self.maxLevel = maxLevel
    self.font = font
    self.color = color
    self.fontIncrease = fontIncrease
  }

  public func formatText(attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
      attributedString.deleteCharacters(in: range)
  }

  public func attributesForLevel(level: Int) -> [String: AnyObject] {
    var attributes = self.attributes
    if let font = font {
      /***
       Previously when parsed:
        #foo  => foo of size 20
        ######foo => foo of size 32
       
       Now when parsed (as it should be conforming to markdown syntax):
       #foo  => foo of size 32
       ######foo => foo of size 20
      ***/
      
      var actualLevel: CGFloat = 0
      if case 0 = level {
        actualLevel = CGFloat(level) + 6
      }
      else if case 1 = level {
        actualLevel = CGFloat(level) + 4
      }
      else if case 2 = level {
        actualLevel = CGFloat(level) + 2
      }
      else if case 3 = level {
        actualLevel = CGFloat(level) + 0
      }
      else if case 4 = level {
        actualLevel = CGFloat(level) - 2
      }
      else if case 5 = level {
        actualLevel = CGFloat(level) - 4
      }
      else if case 6 = level {
        actualLevel = CGFloat(level) - 6
      }
      else {
        actualLevel = 0
      }
      let headerFontSize: CGFloat = font.pointSize + (actualLevel * CGFloat(fontIncrease))
      attributes[NSFontAttributeName] = font.withSize(headerFontSize)
    }
    return attributes
  }
}
