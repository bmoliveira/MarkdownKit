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
  
  @IBOutlet private weak var textView: UITextView!
  private let markdownParser = MarkdownParser()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      textView.attributedText = markdownParser.parse(NSLocalizedString("Markdown", comment: "").stringByDecodingHTMLEntities)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

