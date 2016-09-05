//
//  MarkdownItalic.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

public class MarkdownItalic: MarkdownCommonElement {
  
  private static let regex = "(\\s+|^)(\\*|_)(.+?)(\\2)"
  
  public var font: UIFont?
  public var color: UIColor?
  
  public var regex: String {
    return MarkdownItalic.regex
  }
  
  public init(font: UIFont? = nil, color: UIColor? = nil) {
    self.font = font?.italic()
    self.color = color
  }
  
}
