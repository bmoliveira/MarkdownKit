//
//  MarkdownBold.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownBold: MarkdownCommonElement {
  
  private static let regex = "(\\s+|^)(\\*\\*|__)(.+?)(\\2)"
  
  public var font: UIFont?
  public var color: UIColor?
  
  public var regex: String {
    return MarkdownBold.regex
  }
  
  public init(font: UIFont? = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),
       color: UIColor? = nil) {
    self.font = font
    self.color = color
  }
  
}
