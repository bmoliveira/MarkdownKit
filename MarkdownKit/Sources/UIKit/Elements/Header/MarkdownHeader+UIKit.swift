//
//  MarkdownHeader+UIKit.swift
//  MarkdownKit
//
//  Created by Bruno Oliveira on 31/01/2019.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//

import UIKit

public extension MarkdownHeader {
	#if os(tvOS)
	static let defaultFont = UIFont.preferredFont(forTextStyle: .footnote)
	#else
	   static let defaultFont = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
	#endif
 
}
