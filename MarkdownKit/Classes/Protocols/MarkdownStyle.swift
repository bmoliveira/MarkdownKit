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
var attr: [String:Any] { get }
  var attributes: [String: AnyObject] { get }
}

public extension MarkdownStyle {
  
  var attributes: [String: AnyObject] {
    var attributes = [String: AnyObject]()
    
    attributes = self.attr as [String : AnyObject]
    
    return attributes
  }
  
}
