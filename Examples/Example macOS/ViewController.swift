//
//  ViewController.swift
//  Example-Appkit
//
//  Created by Bruno Oliveira on 31/01/2019.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//

import Cocoa
import MarkdownKit

class ViewController: NSViewController {
  @IBOutlet var label: NSTextView!
  
  fileprivate lazy var viewModel: MarkdownKitViewModel = {
    // Example with custom font
    // fileprivate let markdownParser = MarkdownParser(font: UIFont(name: "Product Sans", size: UIFont.systemFontSize)!)
    let parser = MarkdownParser()
    //parser.addCustomElement(MarkdownSubreddit())
    
    let viewModel = MarkdownKitViewModel(markdownParser: parser)
    viewModel.markdownAttributedStringChanged = { [weak self](attributtedString, error) in
      if let error = error {
        NSLog("Error requesting -> \(error)")
        return
      }
      
      guard let attributedText = attributtedString else {
        NSLog("No error nor string found")
        return
      }
      
      
      let storageSize = self?.label.textStorage?.length ?? 0
      
      self?.label.textStorage?.replaceCharacters(in: NSRange(location: 0, length: storageSize), with: attributedText)
    }
    
    return viewModel
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    viewModel.requestTestPage()
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

