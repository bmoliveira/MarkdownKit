//
//  MarkdownStyle.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

/// Styling protocol for all MarkdownElements
public protocol MarkdownStyle {
  
  var font: UIFont? { get }
  var color: UIColor? { get }
  var attributes: [NSAttributedString.Key: Any] { get }
}

public extension MarkdownStyle {
  
  var attributes: [NSAttributedString.Key: Any] {
    var attributes = [NSAttributedString.Key: Any]()
    if let font = font {
      attributes[.font] = font
    }
    if let color = color {
      attributes[.foregroundColor] = color
    }
    return attributes
  }
  
}
