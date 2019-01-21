Pod::Spec.new do |s|
  s.name                  = "MarkdownKit"
  s.version               = "1.4"
  s.summary               = "MarkdownKit is a customizable and extensible Markdown parser for iOS."
  s.description           = <<-DESC
MarkdownKit is a customizable and extensible Markdown parser for iOS.
It supports many of the standard Markdown elements through the use of Regular
Expressions. It also allows customization of font and color attributes for
all the Markdown elements.
                      DESC
  s.homepage              = "https://github.com/bmoliveira/MarkdownKit"
  s.screenshots           = "https://raw.githubusercontent.com/bmoliveira/MarkdownKit/master/Resources/MarkdownKitExample.png"
  s.license               = {:type => "MIT", :file => "LICENSE"}
  s.author                = {"Ivan Bruel" => "ivan.bruel@gmail.com"}
  s.source                = {:git => "https://github.com/bmoliveira/MarkdownKit.git", :tag => s.version.to_s}
  s.social_media_url      = "https://twitter.com/ivanbruel"

  s.ios.deployment_target = "9.0"

  s.source_files          = "MarkdownKit/Sources/**/*"
  s.frameworks            = "UIKit"
end
