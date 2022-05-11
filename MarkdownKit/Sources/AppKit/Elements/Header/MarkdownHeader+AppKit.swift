//
//  MarkdownHeader+UIKit.swift
//  MarkdownKit
//
//  Created by Bruno Oliveira on 31/01/2019.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//
#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

public extension MarkdownHeader {
  static let defaultFont = NSFont.boldSystemFont(ofSize: NSFont.systemFontSize)
}

#endif
