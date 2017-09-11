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
  var attributes: [NSAttributedStringKey: AnyObject] { get }
}

public extension MarkdownStyle {
  
  var attributes: [NSAttributedStringKey: AnyObject] {
    var attributes = [NSAttributedStringKey: AnyObject]()
    if let font = font {
      attributes[NSAttributedStringKey.font] = font
    }
    if let color = color {
      attributes[NSAttributedStringKey.foregroundColor] = color
    }
    return attributes
  }
  
}
