//
//  String+HTMLDecode.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// Mapping from XML/HTML character entity reference to character
// From http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
private let characterEntities: [String: Character] = [
  // XML predefined entities:
  "&quot;"    : "\"",
  "&amp;"     : "&",
  "&apos;"    : "'",
  "&lt;"      : "<",
  "&gt;"      : ">",
  
  // HTML character entity references:
  "&nbsp;"    : "\u{00a0}",
  // ...
  "&diams;"   : "♦",
]

extension String {
  
  /// Returns a new string made by replacing in the `String`
  /// all HTML character entity references with the corresponding
  /// character.
  var stringByDecodingHTMLEntities: String {
    
    // ===== Utility functions =====
    
    // Convert the number in the string to the corresponding
    // Unicode character, e.g.
    //    decodeNumeric("64", 10)   --> "@"
    //    decodeNumeric("20ac", 16) --> "€"
    func decodeNumeric(_ string: String, base: Int32) -> Character? {
      let code = UInt32(strtoul(string, nil, base))
      return Character(UnicodeScalar(code)!)
    }
    
    // Decode the HTML character entity to the corresponding
    // Unicode character, return `nil` for invalid input.
    //     decode("&#64;")    --> "@"
    //     decode("&#x20ac;") --> "€"
    //     decode("&lt;")     --> "<"
    //     decode("&foo;")    --> nil
    func decode(_ entity: String) -> Character? {
      
      if entity.hasPrefix("&#x") || entity.hasPrefix("&#X") {
        return decodeNumeric(entity.substring(from: entity.characters.index(entity.startIndex, offsetBy: 3)), base: 16)
      } else if entity.hasPrefix("&#") {
        return decodeNumeric(entity.substring(from: entity.characters.index(entity.startIndex, offsetBy: 2)), base: 10)
      } else {
        return characterEntities[entity]
      }
    }
    
    // ===== Method starts here =====
    
    var result = ""
    var position = startIndex
    
    // Find the next '&' and copy the characters preceding it to `result`:
    while let ampRange = self.range(of: "&", range: position ..< endIndex) {
      result.append(self[position ..< ampRange.lowerBound])
      position = ampRange.lowerBound
      
      // Find the next ';' and copy everything from '&' to ';' into `entity`
      if let semiRange = self.range(of: ";", range: position ..< endIndex) {
        let entity = self[position ..< semiRange.upperBound]
        position = semiRange.upperBound
        
        if let decoded = decode(entity) {
          // Replace by decoded character:
          result.append(decoded)
        } else {
          // Invalid entity, copy verbatim:
          result.append(entity)
        }
      } else {
        // No matching ';'.
        break
      }
    }
    // Copy remaining characters to `result`:
    result.append(self[position ..< endIndex])
    return result
  }
}
