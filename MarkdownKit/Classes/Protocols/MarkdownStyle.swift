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
  var attributes: [String: AnyObject] { get }
}

public extension MarkdownStyle {
  
  var attributes: [String: AnyObject] {
    var attributes = [String: AnyObject]()
    if let font = font {
      attributes[NSFontAttributeName] = font
    }
    if let color = color {
      attributes[NSForegroundColorAttributeName] = color
    }
    return attributes
  }
  
}