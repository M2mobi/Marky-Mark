# Marky Mark

Marky Mark is a parser written in Swift that converts markdown into native views. The way it looks it highly customizable and the supported markdown syntax is easy to extend.

[![Screenshot](https://i.imgsafe.org/b2a1373357.png)](https://i.imgsafe.org/b2a75a3cfa.png)
[![Screenshot](https://i.imgsafe.org/b2a14ba35a.png)](https://i.imgsafe.org/b2a7711e10.png)
[![Screenshot](https://i.imgsafe.org/b2a14392fa.png)](https://i.imgsafe.org/b2a762331c.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 8.0+ 
- Xcode 7.3+

## Installation

CocoaPods 1.0.0+ is required to build MarkyMark

To integrate MarkyMark into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod "markymark"
```

## Usage

```
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
```code```
```


### Customizing default style

Default Styling instance

```
  var styling = DefaultStyling()
```

Changing the color of links

```
  styling.linkStyling.textColor = .blueColor()
```

Setting fonts for headers

```
  styling.headingStyling.fontsForLevels = [
      UIFont.boldSystemFontOfSize(24), //H1
      UIFont.systemFontOfSize(18),     //H2
      UIFont.systemFontOfSize(16)      //H3
  ]
```
Adding margins

```
  styling.paragraphStyling.contentInsets.bottom = 20
```

### Creating your own style
```
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

```
markyMark.addRule(MyCustomRule())
```

Add the block builder to your layout converter

```
converter.addLayoutBlockBuilder(MyCustomLayoutBlockBuilder())
```

If needed you can also add a custom styling class to the default styling

```
styling.addStyling(MyCustomStyling())
```

### Converter hook
The converter has a callback method which is called every time a `MarkDownItem` is converted to layout. 

```
converter.didConvertElement = {
    markDownItem, view in
}
```

## Author

M2mobi, info@m2mobi.com

## License

MarkyMark is available under the MIT license. See the LICENSE file for more info.
