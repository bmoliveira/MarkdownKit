//
//  MarkdownLinkElement.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//

import UIKit

/// The base to all Link parsing elements.
public protocol MarkdownLinkElement: MarkdownElement, MarkdownStyle {
  
  func formatText(attributedString: NSMutableAttributedString, range: NSRange, link: String)
  func addAttributes(attributedString: NSMutableAttributedString, range: NSRange, link: String)
}
