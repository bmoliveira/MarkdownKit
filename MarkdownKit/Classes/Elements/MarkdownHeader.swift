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
  
  private enum MarkdownHeadingElements: CGFloat {
    case oneHash = 6,
    twoHashes = 4,
    threeHashes = 2,
    fourHashes = 0,
    fiveHashes = -2,
    sixHashes = -4,
    zeroHash = -6
  }

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
      
      var actualLevel: CGFloat
      if case 0 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.oneHash.rawValue
      }
      else if case 1 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.twoHashes.rawValue
      }
      else if case 2 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.threeHashes.rawValue
      }
      else if case 3 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.fourHashes.rawValue
      }
      else if case 4 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.fiveHashes.rawValue
      }
      else if case 5 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.sixHashes.rawValue
      }
      else if case 6 = level {
        actualLevel = CGFloat(level) + MarkdownHeadingElements.zeroHash.rawValue
      }
      else {
        actualLevel = MarkdownHeadingElements.fourHashes.rawValue
      }
      
      let headerFontSize: CGFloat = font.pointSize + (actualLevel * CGFloat(fontIncrease))
      attributes[NSFontAttributeName] = font.withSize(headerFontSize)
    }
    return attributes
  }
}
