//
//  UIFont+Traits.swift
//  Pods
//
//  Created by Ivan Bruel on 19/07/16.
//
//
import UIKit

extension UIFont {

  func withTraits(_ traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
    let descriptor = fontDescriptor
      .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
    return UIFont(descriptor: descriptor!, size: 0)
  }

  func bold() -> UIFont {
    if let boldFont = MarkdownCustomFont.traits.bold {
      return boldFont
    } else {
      return withTraits(.traitBold)
    }
  }

  func italic() -> UIFont {
    if let italicFont = MarkdownCustomFont.traits.italic {
      return italicFont
    } else {
      return withTraits(.traitItalic)
    }
  }
}
