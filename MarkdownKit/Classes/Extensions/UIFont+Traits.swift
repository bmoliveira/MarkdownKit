//
//  UIFont+Traits.swift
//  Pods
//
//  Created by Ivan Bruel on 19/07/16.
//
//
import UIKit

extension UIFont {

  func withTraits(traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
    let descriptor = fontDescriptor()
      .fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
    return UIFont(descriptor: descriptor, size: 0)
  }

  func bold() -> UIFont {
    return withTraits(.TraitBold)
  }

  func italic() -> UIFont {
    return withTraits(.TraitItalic)
  }
}
