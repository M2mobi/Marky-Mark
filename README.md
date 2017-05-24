# Marky Mark

Marky Mark is a parser written in Swift that converts markdown into native views. The way it looks it highly customizable and the supported markdown syntax is easy to extend.

[![Screenshot](Readme_Assets/example1-thumb.png)](Readme_Assets/example1.png)
[![Screenshot](Readme_Assets/example2-thumb.png)](Readme_Assets/example2.png)
[![Screenshot](Readme_Assets/example3-thumb.png)](Readme_Assets/example3.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 8.0+ 
- Xcode 8.0+

## Installation

CocoaPods 1.0.0+ is required to build MarkyMark

To integrate MarkyMark into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod "markymark"
```

## Usage

```swift
let markyMark = MarkyMark(build: {
  $0.setFlavor(ContentfulFlavor())
})

let markDownItems = markyMark.parseMarkDown("# Header\nParagraph")
var styling = DefaultStyling()
let configuration = MarkdownToViewConverterConfiguration(styling : styling)
let converter = MarkDownConverter(configuration:configuration)

let markDownView = converter.convert(markDownItems)
```


## Supported tags in the Contentful Flavor
```
Headings
# H1
## H2
### H3
#### H4
##### H5
###### H6

Lists
- item
  - item
* item
  * item
+ item
  + item
a. item
b. item
1. item
2. item

Emphasis
*Em*
_Em_
**Strong**
__Strong__
~~Strike through~~

Images
![Alternative text](image.png)

Links
[Link text](https://www.example.net)

Code 
`code`
\```code```
```


### Customizing default style

Default Styling instance

```swift
var styling = DefaultStyling()
```

Changing the color of links

```swift
styling.linkStyling.textColor = .blueColor()
```

Setting fonts for headers

```swift
styling.headingStyling.fontsForLevels = [
    UIFont.boldSystemFontOfSize(24), //H1
    UIFont.systemFontOfSize(18),     //H2
    UIFont.systemFontOfSize(16)      //H3
]
```
Adding margins

```swift
styling.paragraphStyling.contentInsets.bottom = 20
```

### Creating your own style
```swift
struct MarkDownStyling: Styling {
  var headerStyling = HeaderStyling()
  var paragraphStyling = ParagraphStyling()
  var linkStyling = ListStyling()
}
```

## Advanced usage
### Adding your own rules
Adding a new rule requires three new classes of based on the following protocol:

* `Rule` that can recoginizes the desired markdown syntax
* `MarkDownItem` for your new element that will be created by your new rule
* `LayoutBlockBuilder` that can convert your MarkDownItem to layout

Add the rule to MarkyMark

```swift
markyMark.addRule(MyCustomRule())
```

Add the block builder to your layout converter

```swift
converter.addLayoutBlockBuilder(MyCustomLayoutBlockBuilder())
```

If needed you can also add a custom styling class to the default styling

```swift
styling.addStyling(MyCustomStyling())
```

### Converter hook
The converter has a callback method which is called every time a `MarkDownItem` is converted to layout. 

```swift
converter.didConvertElement = { markDownItem, view in
  // Do something with markDownItem and / or view here
}
```

## Author

M2mobi, info@m2mobi.com

## License

MarkyMark is available under the MIT license. See the LICENSE file for more info.
