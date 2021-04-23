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

    func testParseBoldItalicStrikethrough() throws {
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
            "~~__*Bold-Italic-Strikethrough*__~~",
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

            XCTAssertTrue(!attributedString.isSurroundedBy("*", "_", "__", "**", "~~"))
            XCTAssertTrue(font.contains(attribute: .bold))
            XCTAssertTrue(font.contains(attribute: .italic))
            XCTAssertNotNil(attributes[NSAttributedString.Key.strikethroughStyle])
        }
    }

    func testParseBoldItalic() throws {
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
            XCTAssertTrue(!attributedString.isSurroundedBy("*", "_", "__", "**"))
            XCTAssertTrue(font.contains(attribute: .bold))
            XCTAssertTrue(font.contains(attribute: .italic))
        }
    }

    func testParseBold() throws {
        let combinations = [
            "**Bold**",
            "__Bold__",
        ]

        combinations.forEach {
            let attributedString = sut.parse($0)
            let attributes = attributedString.attributes(at: 0, effectiveRange: nil)
            guard let font = attributes[NSAttributedString.Key.font] as? MarkdownFont else {
                XCTFail("Font attributes missing")
                return
            }
            XCTAssertTrue(!attributedString.isSurroundedBy("__", "**"))
            XCTAssertTrue(font.contains(attribute: .bold))
        }
    }

    func testParseItalic() throws {
        let combinations = [
            "*Italic*",
            "_Italic_"
        ]

        combinations.forEach {
            let attributedString = sut.parse($0)
            let attributes = attributedString.attributes(at: 0, effectiveRange: nil)
            guard let font = attributes[NSAttributedString.Key.font] as? MarkdownFont else {
                XCTFail("Font attributes missing")
                return
            }
            XCTAssertTrue(!attributedString.isSurroundedBy("*", "_"))
            XCTAssertTrue(font.contains(attribute: .italic))
        }
    }

    func testParseStrikethrough() throws {
        let attributedString = sut.parse("~~Strikethrough~~")
        let attributes = attributedString.attributes(at: 0, effectiveRange: nil)
        XCTAssertNotNil(attributes[NSAttributedString.Key.strikethroughStyle])
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

fileprivate extension NSAttributedString {
    func isSurroundedBy(_ occurrences: String...) -> Bool {
        occurrences.map {
            string.hasPrefix($0) || string.hasSuffix($0)
        }.first(where: { $0 == true }) != nil
    }
}
