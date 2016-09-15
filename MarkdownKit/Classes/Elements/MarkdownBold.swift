//
//  MarkdownBold.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

open class MarkdownBold: MarkdownCommonElement {
  
  fileprivate static let regex = "(\\s+|^)(\\*\\*|__)(.+?)(\\2)"
  
  open var font: UIFont?
  open var color: UIColor?
  
  open var regex: String {
    return MarkdownBold.regex
  }
  
  public init(font: UIFont? = nil, color: UIColor? = nil) {
    self.font = font?.bold()
    self.color = color
  }
  
}
