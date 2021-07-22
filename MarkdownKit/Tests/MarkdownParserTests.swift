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

    var sut: MarkdownParser!

    override func setUp() {
        sut = MarkdownParser()
    }

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

    struct Link {
        var title: String
        var url: String
        var prefix: String = ""
        var suffix: String = ""
        var string: String {
            "\(prefix)[\(title)](\(url))\(suffix)"
        }
    }

    func testParseLink() throws {
        let links: [Link] = [
            Link(title: "Link", url: "https://example.com/test.html"),
            Link(title: "Link", url: "http://example.com/test.html"),
            Link(title: "Link", url: "example.com/test.html"),
            Link(title: "Link", url: "https://example.com/test.html"),
            Link(title: "Link", url: "https://example.com/test.html", prefix: "(", suffix: ")"),
            Link(title: "Link", url: "https://example.com/test(1).html"),
            Link(title: "Link", url: "https://example.com/test(1).html", prefix: "(", suffix: ")"),
            Link(title: "Link", url: "example.com/test(1).html"),
            Link(title: "Link", url: "http://example.com/test(1)/another/test(2)"),
            Link(title: "Link", url: "example.com/test(1)/another/test(2)"),
            Link(title: "Link", url: "http://example.com/test(1).html"),
            Link(title: "Lin(k", url: "http://example.com/test.html"),
            Link(title: "Lin(k", url: "http://example.com/test.html", prefix: "((("),
            Link(title: "Lin(k", url: "http://example.com/test.html", suffix: ")))"),
            Link(title: "Lin(k", url: "http://example.com/tes(t).html", prefix: "((", suffix: "))"),
            Link(title: "Lin(k", url: "http://example.com/test.html", prefix: "(", suffix: "))))"),
            Link(title: "Lin(k", url: "http://example.com/test.html", prefix: "wwc(", suffix: ")w)ss))"),
            Link(title: "Li)nk", url: "http://example.com/test.html"),
            Link(title: "(Link)", url: "http://example.com/test.html")
        ]

        links.forEach {
            let attributedString = sut.parse($0.string)

            if !$0.prefix.isEmpty {
                var prefixRange = NSRange(0..<$0.prefix.count)
                let prefixAttributes = attributedString.attributes(at: 0, effectiveRange: &prefixRange)

                XCTAssertNil(prefixAttributes[NSAttributedString.Key.link])
            }

            var range = NSRange(0..<($0.title.count))
            let attributes = attributedString.attributes(at: $0.prefix.count, effectiveRange: &range)
            let linkAttribute = attributes[NSAttributedString.Key.link]

            XCTAssertNotNil(linkAttribute)
            if $0.url.starts(with: "http") {
                XCTAssertEqual((linkAttribute as! NSURL).absoluteString, $0.url)
            } else {
                XCTAssertEqual((linkAttribute as! NSURL).absoluteString, "https://" + $0.url)
            }

            if !$0.suffix.isEmpty {
                var suffixRange = NSRange(0..<$0.suffix.count)
                let suffixAttributes = attributedString.attributes(at: $0.title.count + $0.prefix.count, effectiveRange: &suffixRange)

                XCTAssertNil(suffixAttributes[NSAttributedString.Key.link])
            }
        }
    }

    func testLinkShouldObtainDefaultScheme() {
        let links: [Link] = [
            Link(title: "Link", url: "example.com/test.html"),
            Link(title: "Link", url: "https://example.com/test.html"),
        ]

        let defaultScheme = "http://"

        sut = MarkdownParser()
        sut.link.defaultScheme = defaultScheme

        XCTAssertEqual(sut.parse(links[0].string).link, defaultScheme + links[0].url)
        XCTAssertEqual(sut.parse(links[1].string).link, links[1].url)
    }


    func testLinkShouldParseDifferentSchemes() {
        let links: [Link] = [
            Link(title: "Link", url: "https://example.com/test.html"),
            Link(title: "Link", url: "http://example.com/test.html"),
            Link(title: "Link", url: "mailto://test@test.de"),
            Link(title: "Link", url: "tel://123575433"),
        ]

        links.forEach {
            let attributedString = sut.parse($0.string)
            XCTAssertEqual(attributedString.link, $0.url)
        }
    }

    func testLinkShouldFallbackToHttps() {
        let link = Link(title: "Link", url: "example.com/test.html")
        let attributedString = sut.parse(link.string)
        XCTAssertEqual(attributedString.link, "https://" + link.url)
        XCTAssertNil(sut.link.defaultScheme)
    }

    func testParseSimpleList() {
        let markdown = "* first item\n* second item"
        let attributedString = sut.parse(markdown)
        XCTAssertTrue(attributedString.string.contains(sut.list.separator))
    }

    func testParseListWithLotsOfSpacesAfterIndicator() {
        let markdown = "*                                 first item\n*   second item"
        let attributedString = sut.parse(markdown)
        XCTAssertTrue(attributedString.string.contains(sut.list.separator))
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

    var link: String {
        var range = NSRange(0..<self.length)
        let attributes = self.attributes(at: 0, effectiveRange: &range)
        return (attributes[NSAttributedString.Key.link] as? NSURL)?.absoluteString ?? ""
    }
}
