//
//  MarkdownBold.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownBold: MarkdownCommonElement {
  fileprivate static let regex = "(.?|^)(\\*\\*|__)(?=\\S)(.+?)(?<=\\S)(\\2)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  
  open var regex: String {
    return MarkdownBold.regex
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font?.bold()
    self.color = color
  }
}
