//
//  Tests.swift
//  Tests
//
//  Created by Jan Gaebel on 22.04.21.
//  Copyright © 2021 Ivan Bruel. All rights reserved.
//

import XCTest
@testable import MarkdownKit
class Tests: XCTestCase {

    let sut: MarkdownParser = MarkdownParser()

    func testBoldItalicStrikethrough() throws {
        let combinations = [
            "___~~Bold-Italic-Strikethrough~~___",
            "***~~Bold-Italic-Strikethrough~~***",
            "**_~~Bold-Italic-Strikethrough~~_**",
            "*__~~Bold-Italic-Strikethrough~~__*",
            "__*~~Bold-Italic-Strikethrough~~*__",
            "_**~~Bold-Italic-Strikethrough~~**_",
            "_~~**Bold-Italic-Strikethrough**~~_",
            "*~~__Bold-Italic-Strikethrough__~~*",
            "__~~*Bold-Italic-Strikethrough*~~__",
            "**~~_Bold-Italic-Strikethrough_~~**",
            "__~~_Bold-Italic-Strikethrough_~~__",
            "**~~*Bold-Italic-Strikethrough*~~**",
            "~~*__Bold-Italic-Strikethrough__*~~",
            "~~__*Bold-Italic-Strikethrough**__~~",
            "~~*__Bold-Italic-Strikethrough__*~~",
            "~~_**Bold-Italic-Strikethrough**_~~",
            "~~**_Bold-Italic-Strikethrough_**~~",
            "~~___Bold-Italic-Strikethrough___~~",
            "~~***Bold-Italic-Strikethrough***~~"
        ]

        combinations.forEach {
            let attributedString = sut.parse($0)
            let attributes = attributedString.attributes(at: 0, effectiveRange: nil)
            guard let font = attributes[NSAttributedString.Key.font] as? MarkdownFont else {
                XCTFail("Font attributes missing")
                return
            }

            XCTAssertTrue(font.contains(attribute: .bold))
            XCTAssertTrue(font.contains(attribute: .italic))
            XCTAssertNotNil(attributes[NSAttributedString.Key.strikethroughStyle])
        }
    }

    func testBoldItalic() throws {
        let combinations = [
            "***Bold-Italic***",
            "___Bold-Italic___",
            "**_Bold-Italic_**",
            "_**Bold-Italic**_",
            "__*Bold-Italic*__",
            "*__Bold-Italic__*"
        ]

        combinations.forEach {
            let attributedString = sut.parse($0)
            let attributes = attributedString.attributes(at: 0, effectiveRange: nil)
            guard let font = attributes[NSAttributedString.Key.font] as? MarkdownFont else {
                XCTFail("Font attributes missing")
                return
            }
            XCTAssertTrue(font.contains(attribute: .bold))
            XCTAssertTrue(font.contains(attribute: .italic))
        }
    }
}

fileprivate extension MarkdownFont {

    enum AttributeType {
        case bold, italic
    }

    func contains(attribute: AttributeType) -> Bool {
        #if canImport(AppKit)
        let traits = NSFontManager().traits(of: self)
        #elseif canImport(UIKit)
        let traits = self.fontDescriptor.symbolicTraits
        #endif

        switch attribute {
        case .bold:
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            return traits.contains(NSFontTraitMask.boldFontMask)
            #elseif canImport(UIKit)
            return traits.contains(.traitBold)
            #endif
        case .italic:
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            return traits.contains(NSFontTraitMask.italicFontMask)
            #elseif canImport(UIKit)
            return traits.contains(.traitItalic)
            #endif
        }
    }
}
