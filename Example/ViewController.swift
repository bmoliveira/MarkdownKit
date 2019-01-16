//
//  ViewController.swift
//  MarkdownKit
//
//  Created by Ivan Bruel on 07/18/2016.
//  Copyright (c) 2016 Ivan Bruel. All rights reserved.
//

import UIKit
import MarkdownKit

class ViewController: UIViewController {
  
  @IBOutlet fileprivate weak var textView: UITextView! {
    didSet {
      textView.delegate = self
    }
  }
  
  // Example with custom font
  // fileprivate let markdownParser = MarkdownParser(font: UIFont(name: "Product Sans", size: UIFont.systemFontSize)!)
  
  fileprivate let markdownParser = MarkdownParser()
  override func viewDidLoad() {
    super.viewDidLoad()
    markdownParser.addCustomElement(MarkdownSubreddit())
      textView.attributedText = markdownParser.parse(NSLocalizedString("Markdown", comment: "").stringByDecodingHTMLEntities)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension ViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                in characterRange: NSRange) -> Bool {
    UIApplication.shared.open(URL, options: [:])
    //UIApplication.shared.openURL(URL)
    return true
  }
  
}
