![Logo](https://raw.githubusercontent.com/ivanbruel/MarkdownKit/master/Resources/MarkdownKitLogo.png)

MarkdownKit
=========

[![Version](https://img.shields.io/cocoapods/v/MarkdownKit.svg?style=flat)](http://cocoapods.org/pods/MarkdownKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/MarkdownKit.svg?style=flat)](http://cocoapods.org/pods/MarkdownKit)
[![Platform](https://img.shields.io/cocoapods/p/MarkdownKit.svg?style=flat)](http://cocoapods.org/pods/MarkdownKit)

MarkdownKit is a customizable and extensible Markdown parser for iOS. It supports many of the standard Markdown elements through the use of Regular Expressions. It also allows customization of font and color attributes for all the Markdown elements.

## Screenshot

![Example](https://raw.githubusercontent.com/ivanbruel/MarkdownKit/master/Resources/MarkdownKitExample.png)

## Installation

### Installation via CocoaPods

MarkdownKit is available through [CocoaPods](http://cocoapods.org). CocoaPods is a dependency manager that automates and simplifies the process of using 3rd-party libraries like MarkdownKit in your projects. You can install CocoaPods with the following command:

```ruby
gem install cocoapods
```

To integrate MarkdownKit into your Xcode project using CocoaPods, simply add the following line to your Podfile:

```ruby
pod "MarkdownKit"
```

Afterwards, run the following command:

```ruby
pod install
```

### Installation via Carthage

MarkdownKit is available through [Carthage](https://github.com/Carthage/Carthage). Carthage is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage via [Homebrew](http://brew.sh) with the following command:

```ruby
brew update
brew install carthage
```

To integrate MarkdownKit into your Xcode project using Carthage, simply add the following line to your Cartfile:

```ruby
github "ivanbruel/MarkdownKit"
```

Afterwards, run the following command:

```ruby
carthage update
```

## Supported Elements

```
*italic* or _italics_
**bold** or __bold__
~~strikethrough~~

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
let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 18))
markdownParser.enabledElements = .disabledAutomaticLink
markdownParser.bold.color = UIColor.red
markdownParser.italic.font = UIFont.italicSystemFont(ofSize: 300)
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
