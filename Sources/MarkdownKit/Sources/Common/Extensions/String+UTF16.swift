//
//  String+UTF16.swift
//  Pods
//
//  Created by Ivan Bruel on 19/07/16.
//
//
import Foundation

extension String {
  
  /// Converts each character to its UTF16 form in hexadecimal value (e.g. "H" -> "0048")
  func escapeUTF16() -> String {
    return Array(utf16).map {
      String(format: "%04x", $0)
    }.reduce("") {
      return $0 + $1
    }
  }
  
  /// Converts each 4 digit characters to its String form  (e.g. "0048" -> "H")
  func unescapeUTF16() -> String? {
    
    //This is an hot fix for the crash when a regular string is passed here.
     guard count % 4 == 0 else {
      return self
    }
 
    var utf16Array = [UInt16]()
    stride(from: 0, to: count, by: 4).forEach {
      let startIndex = index(self.startIndex, offsetBy: $0)
      let endIndex = index(self.startIndex, offsetBy: $0 + 4)
      let hex4 = String(self[startIndex..<endIndex])
      if let utf16 = UInt16(hex4, radix: 16) {
        utf16Array.append(utf16)
      }
    }
    
    return String(utf16CodeUnits: utf16Array, count: utf16Array.count)
  }
}
