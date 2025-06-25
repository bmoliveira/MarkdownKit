import Foundation
import MarkdownKit

class MarkdownLineBreak: MarkdownElement {
    internal let regex = "\n{3,}"

  public func regularExpression() throws -> NSRegularExpression {
    try NSRegularExpression(pattern: regex)
  }

  public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
    attributedString.replaceCharacters(in: match.range(at: 0), with: "\n\n")
  }
}
