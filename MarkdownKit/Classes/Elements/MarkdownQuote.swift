//
//  MarkdownQuote.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownQuote: MarkdownLevelElement {

  private static let regex = "^(\\>{1,%@})\\s*(.+)$"

  public var maxLevel: Int
  public var font: UIFont?
  public var color: UIColor?
  public var separator: String
  public var indicator: String

  public var regex: String {
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownQuote.regex, level)
  }

  public init(maxLevel: Int = 0, indicator: String = ">", separator: String = "  ", font: UIFont? = nil,
              color: UIColor? = nil) {
    self.maxLevel = maxLevel
    self.indicator = indicator
    self.separator = separator
    self.font = font
    self.color = color
  }


  public func formatText(attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    var string = (0..<level).reduce("") { (string: String, _: Int) -> String in
      return "\(string)\(separator)"
    }
    string = "\(string)\(indicator) "
    attributedString.replaceCharacters(in: range, with: string)
  }
}
