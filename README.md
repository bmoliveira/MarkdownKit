![Logo](https://raw.githubusercontent.com/ivanbruel/MarkdownKit/master/Resources/MarkdownKitLogo.png)

MarkdownKit
=========

[![Version](https://img.shields.io/cocoapods/v/MarkdownKit.svg?style=flat)](http://cocoapods.org/pods/MarkdownKit)
[![License](https://img.shields.io/cocoapods/l/MarkdownKit.svg?style=flat)](http://cocoapods.org/pods/MarkdownKit)
[![Platform](https://img.shields.io/cocoapods/p/MarkdownKit.svg?style=flat)](http://cocoapods.org/pods/MarkdownKit)

MarkdownKit is a customizable and extensible Markdown parser for iOS. It supports many of the standard Markdown elements through the use of Regular Expressions. It also allows customization of font and color attributes for all the Markdown elements.

## Screenshot

![Example](https://raw.githubusercontent.com/ivanbruel/MarkdownKit/master/Resources/MarkdownKitExample.png)

## Installation

MarkdownKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MarkdownKit"
```

## Supported Elements

```
*italic* or _italics_
**bold** or __bold__

# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6

> Quote

* List
- List
+ List

`code` or ```code```
[Links](http://github.com/ivanbruel/MarkdownKit/)
```

## Usage

In order to use MarkdownKit to transform Markdown into NSAttributedString, all you have to do is create an instance of `MarkdownParser` and call the `parse(_)` function.

```swift
let markdownParser = MarkdownParser()
let markdown = "I support a *lot* of custom Markdown **Elements**, even `code`!"
label.attributedText = markdownParser.parse(markdown)
```

## Customization

```swift
let markdownParser = MarkdownParser(font: UIFont.systemFontOfSize(18))
markdownParser.automaticLinkDetectionEnabled = false
markdownParser.bold.color = UIColor.redColor()
markdownParser.italic.font = UIFont.italicSystemFontOfSize(300)
markdownParser.header.fontIncrease = 4
```

## Extensibility

To add new Markdown elements all you have to do is implement the `MarkdownElement` protocol (or descendants) and add it to the `MarkdownParser`.

```swift
import MarkdownKit

class MarkdownSubreddit: MarkdownLink {

  private static let regex = "(^|\\s|\\W)(/?r/(\\w+)/?)"

  override var regex: String {
    return MarkdownSubreddit.regex
  }

  override func match(match: NSTextCheckingResult,
                             attributedString: NSMutableAttributedString) {
    let subredditName = attributedString.attributedSubstringFromRange(match.rangeAtIndex(3)).string
    let linkURLString = "http://reddit.com/r/\(subredditName)"
    formatText(attributedString, range: match.range, link: linkURLString)
    addAttributes(attributedString, range: match.range, link: linkURLString)
  }

}
```

```swift
let markdownParser = MarkdownParser(customElements: [MarkdownSubreddit()])
let markdown = "**/r/iosprogramming** can be *markdown* as well!"
label.attributedText = markdownParser.parse(markdown)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Acknowledgements

This library is heavily inspired in [TSMarkdownParser](https://github.com/laptobbe/TSMarkdownParser) and also [SwiftyMarkdown](https://github.com/SimonFairbairn/SwiftyMarkdown).

Special thanks to [Michael Brown](https://github.com/mluisbrown) for helping out with the [UTF-16 Escaping/Unescaping](https://github.com/ivanbruel/MarkdownKit/blob/master/MarkdownKit/Classes/Extensions/String%2BUTF16.swift).

## License

MarkdownKit is available under the MIT license. See the LICENSE file for more info.
