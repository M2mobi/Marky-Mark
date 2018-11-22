//
//  Created by Jim van Zummeren on 11/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class MarkyMarkContentfulIntegrationTests: XCTestCase {

    var sut: MarkyMark!

    override func setUp() {
        super.setUp()

        sut = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })
    }

    func testParseMarkDownReturnsCorrectNumberOfRootItems() {
        //Arrange
        let markDownString = "# First\n"
            + "**Second**\n"
            + "```Third\n\n\n ```\n"
            + "- Fourth\n"
            + "- Fourth\n"
            + "- Fourth\n"
            + "![Fifth](image.png)"

        let longerMarkDownString = "# First\n"
        + "[Second](image.png)\n"
        + "*Third*"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)
        let moreMarkDownItems = sut.parseMarkDown(longerMarkDownString)

        //Assert
        XCTAssert(markDownItems.count == 5)
        XCTAssert(moreMarkDownItems.count == 3)
    }

    func testParseMarkDownNestedCombinedLists() {
        //Arrange
        let markDownString = "- Hello\n"
            + "- Hello\n"
            + "  1. Hello\n"
            + "  2. Hello\n"
            + "    a. Hello\n"
            + "    b. Hello\n"
            + "    c. Hello\n"
            + "      - Hello\n"
            + "- Hello"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert((markDownItems[0] as! ListMarkDownItem).listItems![0] is UnorderedListMarkDownItem)
        XCTAssert((markDownItems[0] as! ListMarkDownItem).listItems![1].listItems![1] is OrderedListMarkDownItem)
        XCTAssert((markDownItems[0] as! ListMarkDownItem).listItems![1].listItems![1].listItems![2] is AlphabeticallyOrderedMarkDownItem)
        XCTAssert((markDownItems[0] as! ListMarkDownItem).listItems![1].listItems![1].listItems![2].listItems![0] is UnorderedListMarkDownItem)
    }

    func testParseMarkDownParagraphInlineMarkDownItems() {
        //Arrange
        let markDownString = "Test **bold** and *italic* ***Bold italic*** ***~~bold italic strikethrough~~***"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert((markDownItems[0]) is ParagraphMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![1] is BoldMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![5] is BoldMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![5].markDownItems![0] is ItalicMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![7].markDownItems![0] is ItalicMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![7].markDownItems![0].markDownItems![0] is StrikeMarkDownItem)
    }

    func testHeaderMarkDownParagraphInlineMarkDownItems() {
        //Arrange
        let markDownString = "### [Link](http://www.google.com)**bold** and *italic* ***Bold italic*** ***~~bold italic strikethrough~~***"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert((markDownItems[0]) is HeaderMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![0] is LinkMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![1] is BoldMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![5] is BoldMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![5].markDownItems![0] is ItalicMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![7].markDownItems![0] is ItalicMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![7].markDownItems![0].markDownItems![0] is StrikeMarkDownItem)
    }

    func testListMarkDownInlineMarkDownItems() {
        //Arrange
        let markDownString = "- Hello[Link](http://www.google.com)\n"
            + "  - He*llo*"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert((markDownItems[0] as! ListMarkDownItem).listItems![0].markDownItems![1] is LinkMarkDownItem)
        XCTAssert((markDownItems[0] as! ListMarkDownItem).listItems![0].listItems![0].markDownItems![1] is ItalicMarkDownItem)

    }

    func testCodeBlockDoesNotContainChildMarkDownItems() {
        //Arrange
        let markDownString = "```[Link](http://www.google.com)**bold** and *italic* ***Bold italic*** ***~~bold italic strikethrough~~***```"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert(markDownItems[0].markDownItems == nil)
    }

    func testInlineCodeBlockDoesNotContainChildMarkDownItems() {
        //Arrange
        let markDownString = "Testing `Code block *italic*`"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert(markDownItems[0].markDownItems![1] is InlineCodeMarkDownItem)
        XCTAssertEqual(markDownItems[0].markDownItems![1].markDownItems!.count, 1)
        XCTAssert(markDownItems[0].markDownItems![1].markDownItems![0] is InlineTextMarkDownItem)
    }

    func testHeadersAndHorizontalRuleCombinationWorks() {
        let markDownString = "# Header\n"
            + "---\n"
            + "# Second header\n"
            + "---\n"
            + "Paragraph\n"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert(markDownItems[0] is HeaderMarkDownItem)
        XCTAssert(markDownItems[1] is HorizontalLineMarkDownItem)
        XCTAssert(markDownItems[2] is HeaderMarkDownItem)
    }

    func testLinkAndImageCombinationWork() {
        //Arrange
        let markDownString = "[Link](http://www.google.com)"
            + "![Image](image.png)"
            + "[Link](http://www.google.com)"
            + "[Link](http://www.google.com)"
            + "![Image](image.png)"

        //Act
        let markDownItems = sut.parseMarkDown(markDownString)

        //Assert
        XCTAssert((markDownItems[0]).markDownItems![1] is ImageMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![3] is LinkMarkDownItem)
        XCTAssert((markDownItems[0]).markDownItems![4] is ImageMarkDownItem)
    }

    func testEmojiWorks() {
        let emojiString = "This is an emoji 👍"

        // Act
        let markDownItems = sut.parseMarkDown(emojiString)

        // Assert
        XCTAssert(markDownItems[0] is ParagraphMarkDownItem)
        XCTAssert(markDownItems[0].content == emojiString)
    }

    func testParsingMarkDownPerformance() {
        let markDownString = "# Headers\n---\n# Header 1\n## Header 2\n### Header 3\n#### Header 4\n##### Header 5\n###### Header 6\n\n# Lists\n---\n## Ordered list\n1. Number 1\n2. Number 2\n3. Number 3\n5. Number 4\n  1. Nested 1\n  2. Nested 2\n6. Number 5\n---\n## Unordered list\n- Item 1\n- Item 2\n- Item 3\n  - Nested item 1\n  - ~~Nested item 2~~\n    - Subnested it'em 1\n    - Subnested it'em 2\n      - Subsubnest'ed item 1\n      - Subsubnest'ed item 2 [Velit](https://m2mobi.com)\n      - Subsubnes'ted item 3 *(with single **space**)*\n---\n## Combo\n1. Ordered 1\n2. Ordered 2\n  - Unordered 1\n  - Unordered 2\n  - Nested unorder'ed 1\n  - Nested unorder'ed 2\n    1. Subnested o'rdered 1\n    2. Subnested o'rdered 2\n\n# Images\n---\n![My Apple](http://images.apple.com/apple-events/static/apple-events/october-2013/video/poster_large.jpg)\n\n# Paragraphs\nLorem ipsum *dolor* sit amet, __consectetur__ adipiscing elit. Proin ***aliquet vulputate*** diam. Duis sodales ~~sapien~~ quis ***elementum* posuere**. Duis quam lectus, posueresed  [~~pellentesqueaauctor~~](https://m2mobi.com) eu [Velit](https://m2mobi.com).\n---\n## Quotes\n> MarkDown is awesome\n> Seriously..\n\n## Links\n[This is a test link](https://m2mobi.com)\nInline links are also possible, click [here](https://m2mobi.com)\n# Code\n---\n\n```\n@Override\nOn *multiple* lines\n```\n\n``` @Override ```\n\nOr maybe in line `@Override`"

        // This is an example of a performance test case.
        self.measure {
            _ = self.sut.parseMarkDown(markDownString)
        }
    }

}
