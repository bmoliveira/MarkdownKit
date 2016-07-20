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
  
  @IBOutlet private weak var textView: UITextView! {
    didSet {
      textView.delegate = self
    }
  }
  private let markdownParser = MarkdownParser()
  
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
  
  func textView(textView: UITextView, shouldInteractWithURL URL: NSURL,
                inRange characterRange: NSRange) -> Bool {
    UIApplication.sharedApplication().openURL(URL)
    return true
  }
  
}
