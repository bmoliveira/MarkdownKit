//
//  MarkdownKitViewModel.swift
//  Example
//
//  Created by Bruno Oliveira on 21/01/2019.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//

import Foundation
import MarkdownKit
import Alamofire

class MarkdownKitViewModel {
  
  let markdownParser: MarkdownParser
  
  fileprivate let testingURL: String
  
  var markdownAttributedStringChanged: ((NSAttributedString?, Error?) -> ())? = nil
  
  init(markdownParser: MarkdownParser,
       testingURL: String = "https://raw.githubusercontent.com/apple/swift-evolution/master/proposals/0240-ordered-collection-diffing.md") {
    self.markdownParser = markdownParser
    self.testingURL = testingURL
  }
}

extension MarkdownKitViewModel {
  func parseString(markdownString: String) {
    markdownAttributedStringChanged?(markdownParser.parse(markdownString), nil)
  }
  
  func requestTestPage() {
    AF.request(testingURL).responseString { [weak self]response in
      if let error = response.error {
        self?.markdownAttributedStringChanged?(nil, error)
        return
      }
      if let markdownString = try? response.result.get() {
        self?.parseString(markdownString: markdownString)
      }
    }
  }
}
