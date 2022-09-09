//
//  UIFont+Traits.swift
//  Pods
//
//  Created by Ivan Bruel on 19/07/16.
//
//

#if canImport(UIKit)

import UIKit

extension UIFont {

  func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont? {
    let pointSize = fontDescriptor.pointSize
    guard let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else {
        return nil
    }
    return UIFont(descriptor: descriptor, size: pointSize)
  }

  func bold() -> UIFont {
    return withTraits(fontDescriptor.symbolicTraits, .traitBold) ?? self
  }

  func italic() -> UIFont {
    return withTraits(fontDescriptor.symbolicTraits, .traitItalic) ?? self
  }

  func isItalic() -> Bool {
    return fontDescriptor.symbolicTraits.contains(.traitItalic)
  }

  func isBold() -> Bool {
    return fontDescriptor.symbolicTraits.contains(.traitBold)
  }
}

#endif
