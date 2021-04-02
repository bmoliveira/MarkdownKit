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
      textView.isScrollEnabled = false
    }
  }
  
  fileprivate lazy var attributedStringFromResources: String = {
    return NSLocalizedString("Markdown", comment: "").stringByDecodingHTMLEntities
  }()
  
  fileprivate lazy var viewModel: MarkdownKitViewModel = {
    // Example with custom font
    // fileprivate let markdownParser = MarkdownParser(font: UIFont(name: "Product Sans", size: UIFont.systemFontSize)!)
    let parser = MarkdownParser()
    parser.addCustomElement(MarkdownSubreddit())
    
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
      
      self?.textView.attributedText = attributedText
    }
    
    return viewModel
  }()
  
  fileprivate var resourcesAction: UIAlertAction {
    return UIAlertAction(title: "Resources",
                         style: .default,
                         handler: { [unowned self]_ in
                          self.viewModel.parseString(markdownString: self.attributedStringFromResources)
    })
  }
  
  fileprivate var internetAction: UIAlertAction {
    return UIAlertAction(title: "Internet",
                         style: .default,
                         handler: { [unowned self]_ in
                          self.viewModel.requestTestPage()
    })
  }
  
  fileprivate var actionSheetController: UIAlertController {
    let alert = UIAlertController(title: "Choose the Markdown source", message: nil, preferredStyle: .actionSheet)
    alert.addAction(resourcesAction)
    alert.addAction(internetAction)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
      alert.dismiss(animated: true, completion: nil)
    }))
    return alert
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "MarkdownKit"
    viewModel.parseString(markdownString: attributedStringFromResources)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if (!textView.isScrollEnabled) {
      textView.isScrollEnabled = true
      textView.setContentOffset(.zero, animated: false)
    }
  }
  
  @IBAction func userDidTapSwitch(_ sender: Any) {
    present(actionSheetController, animated: true, completion: nil)
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

