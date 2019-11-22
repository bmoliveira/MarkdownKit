Pod::Spec.new do |s|
  s.name                  = "MarkdownKit"
  s.version               = "1.0"
  s.summary               = "MarkdownKit is a customizable and extensible Markdown parser for iOS."
  s.description           = <<-DESC
A fork of MarkdownKit by bmoliveira (https://github.com/bmoliveira/MarkdownKit). Original description:

MarkdownKit is a customizable and extensible Markdown parser for iOS.
It supports many of the standard Markdown elements through the use of Regular
Expressions. It also allows customization of font and color attributes for
all the Markdown elements.
                      DESC
  s.homepage              = "https://github.com/Accedo-Products/MarkdownKit"
  s.license               = {:type => "MIT", :file => "LICENSE"}
  s.author                = {"Rasmus Berggrén" => "rasmus.berggren@accedo.tv"}
  s.source                = {:git => "https://github.com/Accedo-Products/MarkdownKit", :tag => s.version.to_s}

  s.source_files          = "MarkdownKit/Sources/Common/**/*"

  s.ios.deployment_target = "9.0"
  s.ios.source_files      = "MarkdownKit/Sources/UIKit/**/*"
  s.ios.frameworks        = "UIKit"

  s.osx.deployment_target = '10.10'
  s.osx.source_files      = "MarkdownKit/Sources/AppKit/**/*"
  s.osx.framework         = 'AppKit'

end
