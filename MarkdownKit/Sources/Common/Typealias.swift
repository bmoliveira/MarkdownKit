//
//  Typealias+UIKit.swift
//  MarkdownKit
//
//  Created by Bruno Oliveira on 31/01/2019.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

public typealias MarkdownFont = NSFont
public typealias MarkdownColor = NSColor

public typealias NSMutableParagraphStyle = AppKit.NSMutableParagraphStyle
public typealias NSUnderlineStyle = AppKit.NSUnderlineStyle

#elseif canImport(UIKit)

import UIKit

public typealias MarkdownFont = UIFont
public typealias MarkdownColor = UIColor

public typealias NSMutableParagraphStyle = UIKit.NSMutableParagraphStyle
public typealias NSUnderlineStyle = UIKit.NSUnderlineStyle

#endif
