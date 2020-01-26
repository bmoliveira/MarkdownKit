//
//  MarkdownList.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownList: MarkdownLevelElement {

  fileprivate static let regex = "^( {0,%@}[\\*\\+\\-])\\s+(.+)$"

  open var maxLevel: Int
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var separator: String
  open var indicator: String

  open var regex: String {
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownList.regex, level)
  }

  public init(font: MarkdownFont? = nil, maxLevel: Int = 6, indicator: String = "●",
              separator: String = "  ", color: MarkdownColor? = nil) {
    self.maxLevel = maxLevel
    self.indicator = indicator
    self.separator = separator
    self.font = font
    self.color = color
  }

  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    let levelIndicatorList = [1: "\(indicator)  ", 2: "\(indicator)  ", 3: "◦  ", 4: "◦  ", 5: "▪︎  ", 6: "▪︎  "]
    let levelIndicatorOffsetList = [1: "", 2: "", 3: "  ", 4: "  ", 5: "    ", 6: "    "]
    guard let indicatorIcon = levelIndicatorList[level],
      let offset = levelIndicatorOffsetList[level] else { return }
    let indicator = "\(offset)\(indicatorIcon)"
    attributedString.replaceCharacters(in: range, with: indicator)
    attributedString.addAttributes([.paragraphStyle : defaultParagraphStyle()], range: range)
  }

  private func defaultParagraphStyle() -> NSMutableParagraphStyle {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = 0
    paragraphStyle.headIndent = 16
    paragraphStyle.paragraphSpacing = 4
    return paragraphStyle
  }
}
