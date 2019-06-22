//
//  NSFont+Traits.swift
//  MarkdownKit
//
//  Created by Bruno Oliveira on 31/01/2019.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//

import AppKit

public extension MarkdownFont {
  func italic() -> MarkdownFont {
    return NSFontManager().convert(self, toHaveTrait: NSFontTraitMask.italicFontMask)
  }
  
  func bold() -> MarkdownFont {
    return NSFontManager().convert(self, toHaveTrait: NSFontTraitMask.boldFontMask)
  }
  
  func withSize(_ size: CGFloat) -> NSFont {
    return NSFontManager().convert(self, toSize: size)
  }
}
