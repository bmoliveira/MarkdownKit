//
//  MarkdownKitTests.swift
//  MarkdownKitTests
//
//  Created by Jos van Velzen on 22/01/2021.
//  Copyright © 2021 Ivan Bruel. All rights reserved.
//

import MarkdownKit
import XCTest

class MarkdownKitTests: XCTestCase {
    
    private let markdownParser: MarkdownParser = {
        let parser = MarkdownParser(font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body), color: UIColor.black)
        return parser
    }()
    
    func testLinkWithParenthesesInStartofLinkText() {
        let expected = "(hidden) link on Youtube"
        let testString = "[\(expected)](https://youtube.com)"
        
        let actual = markdownParser.parse(testString)
    

        XCTAssertEqual(actual.string, expected)
    }

    func testLinkWithParenthesesInMiddleOfLinkText() {
        let expected = "link (hidden) on Youtube"
        let testString = "[\(expected)](https://youtube.com)"

        let actual = markdownParser.parse(testString)

        XCTAssertEqual(actual.string, expected)
    }

    func testLinkWithParenthesesInEndOfLinkText() {
        let expected = "link on Youtube (hidden)"
        let testString = "[\(expected)](https://youtube.com)"

        let actual = markdownParser.parse(testString)

        XCTAssertEqual(actual.string, expected)
    }
}
