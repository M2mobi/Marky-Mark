Pod::Spec.new do |s|
  s.name             = "markymark"
  s.version          = "10.1.4"
  s.summary          = "Markdown parser for iOS"
  s.description      = <<-DESC
Marky Mark is a parser written in Swift that converts markdown into native views. The way it looks is highly customizable and the supported markdown syntax and tags are easy to extend.
                       DESC

  s.homepage         = "https://github.com/M2Mobi/Marky-Mark"
  s.license          = 'MIT'
  s.author           = { "M2Mobi" => "info@m2mobi.com" }
  s.source           = { :git => "https://github.com/M2Mobi/Marky-Mark.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'markymark/Classes/**/*{.swift}'
end
