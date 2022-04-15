//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class LinkRuleTests: XCTestCase {

    var sut: LinkRule!

    override func setUp() {
        super.setUp()
        sut = LinkRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["[Alt text](image.png)"]))
        XCTAssertFalse((sut.recognizesLines(["![Alt text](image.png)"])))
        XCTAssertTrue(sut.recognizesLines([#"[Alt text](image.png "some title")"#]))
        XCTAssertTrue(sut.recognizesLines([#"[Alt text](https://www.website.com/ "some-test")"#]))
        XCTAssertTrue(sut.recognizesLines([#"[Alt text](https://www.website.com/ "some"test"with"quotation"marks")"#]))
    }

    func test_DoesNotRecognizeLines_When_PrefixedWithExclamationMark() {
        XCTAssertFalse((sut.recognizesLines(["![Alt text](image.png)"])))
        XCTAssertFalse((sut.recognizesLines(["! [Alt text](image.png)"])))
        XCTAssertFalse((sut.recognizesLines([#"![Alt text](image.png "some title")"#])))
    }

    func test_GetAllMatchesReturnsZero_When_InvalidInput() {
        // Assert
        XCTAssert(sut.getAllMatches(["(https://www.google.com)"]).isEmpty)
        XCTAssert(sut.getAllMatches(["[Google]"]).isEmpty)
        XCTAssert(sut.getAllMatches(["![Google](https://www.google.com)"]).isEmpty)
    }

    func test_MarkDownItemContainsCorrectLink_When_CreatingMarkDownItemWithLines() {
        // Act
        let markDownItem = sut.createMarkDownItemWithLines(["[Google](http://www.google.com)"])
        let markDownItem2 = sut.createMarkDownItemWithLines(["[Youtube](http://www.youtube.com)"])

        // Assert
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).content, "Google")
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).url, "http://www.google.com")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).content, "Youtube")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).url, "http://www.youtube.com")
    }

    func test_MarkDownItemContainsCorrectLink_When_CreatingMarkdownItemWithLinesUsingLinkTitle() {
        // Act
        let markDownItem = sut.createMarkDownItemWithLines([#"[Google](http://www.google.com "Google")"#])
        let markDownItem2 = sut.createMarkDownItemWithLines([#"[Youtube](http://www.youtube.com "You-tube")"#])

        // Assert
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).content, "Google")
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).title, "Google")
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).url, "http://www.google.com")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).content, "Youtube")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).title, "You-tube")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).url, "http://www.youtube.com")
    }

    func test_GetsAllMatches_When_ProvidingLinks() {
        // Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 32)
        let expectedMatchesRange2 = NSRange(location: 38, length: 32)

        // Act + Assert
        XCTAssertEqual(sut.getAllMatches(["[Google]"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["(https://www.google.com)"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["[Google](https://www.google.com)"]), [expectedMatchesRange])
        XCTAssertEqual(sut.getAllMatches(["![Google](https://www.google.com)"]).count, 0)
        XCTAssertEqual(
            sut.getAllMatches(["[Google](https://www.google.com) test [Google](https://www.google.com)"]),
            [expectedMatchesRange, expectedMatchesRange2]
        )
    }

    func test_GetsAllMatches_When_ProvidingLinksWithAdditionalTitleValues() {
        // Act + Assert
        XCTAssertEqual(
            sut.getAllMatches([#"[http://www.google.com](http://www.google.com "title"with"lots"of"quotationmarks")"#]),
            [
                NSRange(location: 0, length: 82)
            ]
        )

        XCTAssertEqual(
            sut.getAllMatches([#"[Google](https://www.google.com "great-url-title") test [Google](https://www.google.com "a11y title")"#]),
            [
                NSRange(location: 0, length: 50),
                NSRange(location: 56, length: 45)
            ]
        )

        XCTAssertEqual(
            sut.getAllMatches([#"[Google](https://www.google.com "great-url-title") test [Google](https://www.google.com "a11y title") and even more [https://www.apple.com](https://www.apple.com "Apple-aria-label") test"#]),
            [
                NSRange(location: 0, length: 50),
                NSRange(location: 56, length: 45),
                NSRange(location: 116, length: 65)
            ]
        )
    }

    func test_FailsToMatch_When_ProvidingLinksWithIncorrectSyntax() {
        // Act + Assert
        XCTAssertTrue(sut.getAllMatches([#"[Google](https://www.google.com great-url-title")"#]).isEmpty)
        XCTAssertTrue(sut.getAllMatches([#"[Google](https://www.google.com great url title")"#]).isEmpty)
    }

    func test_OnlyMatchesFirstLink_When_ProvidingOneCorrectLinkAndOneFaulty() {
        // Act + Assert
        XCTAssertEqual(
            sut.getAllMatches([#"[Google](https://www.google.com "great-url-title") test [Google](https://www.google.com a11y title")"#]),
            [
                NSRange(location: 0, length: 50)
            ]
        )
    }

    func test_ParsesAdditionalTitleItems_When_InputMatches() throws {
        // Arrange
        let cases: [(String, String?, UInt)] = [
            (
                #"[Google w/ title](http://www.google.com "with custom title")"#,
                "with custom title",
                #line
            ),
            (
                #"[Google w/ title](http://www.google.com "with-custom-title")"#,
                "with-custom-title",
                #line
            ),
            (
                #"[http://www.google.com](http://www.google.com "http://www.google.com")"#,
                "http://www.google.com",
                #line
            ),
            (
                #"[plain link](http://www.google.com "1234567890!@#$%^&*()")"#,
                "1234567890!@#$%^&*()",
                #line
            ),
            (
                #"[http://www.google.com](http://www.google.com "title"with"lots"of"quotationmarks")"#,
                #"title"with"lots"of"quotationmarks"#,
                #line
            ),
            (
                #"[plain link](http://www.google.com)"#,
                nil,
                #line
            )
        ]

        for (input, title, line) in cases {
            // Act
            let output = sut.createMarkDownItemWithLines([input])

            // Assert
            let linkMarkDownItem = try XCTUnwrap(output as? LinkMarkDownItem)
            XCTAssertEqual(linkMarkDownItem.title, title, line: line)
        }
    }

    func test_ParsesItem_When_InputMatches() throws {
        // Arrange
        let cases: [(String, String, String, UInt)] = [
            (
                #"[Google plain link](https://google.com)"#,
                "Google plain link",
                "https://google.com",
                #line
            ),
            (
                #"[Google w/ title](http://www.google.com "with custom title")"#,
                "Google w/ title",
                "http://www.google.com",
                #line
            ),
            (
                #"[Simple link](https://google.nl)"#,
                "Simple link",
                "https://google.nl",
                #line
            ),
            (
                #"Inside [another link](http://m2mobi.com/) sentence"#,
                "another link",
                "http://m2mobi.com/",
                #line
            ),
            (
                #"Inside [another link](http://m2mobi.com/ "with custom title") sentence"#,
                "another link",
                "http://m2mobi.com/",
                #line
            ),
            (
                #"[Underscored link](https://google.nl/?param=a_b_c)"#,
                "Underscored link",
                "https://google.nl/?param=a_b_c",
                #line
            ),
            (
                #"[Underscored link 2](https://google.nl/?param=a_b_c&d=e)"#,
                "Underscored link 2",
                "https://google.nl/?param=a_b_c&d=e",
                #line
            ),
            (
                #"[Underscored link 4](https://google.nl/?param=a_b_c&d=e_f_g)"#,
                "Underscored link 4",
                "https://google.nl/?param=a_b_c&d=e_f_g",
                #line
            )
        ]

        for (input, content, url, line) in cases {
            // Act
            let output = sut.createMarkDownItemWithLines([input])

            // Assert
            let linkMarkDownItem = try XCTUnwrap(output as? LinkMarkDownItem)
            XCTAssertEqual(linkMarkDownItem.content, content, line: line)
            XCTAssertEqual(linkMarkDownItem.url, url, line: line)
        }
    }

    func test_LinkItemsAreCorrect_When_CreatingMarkDownItemsWithContent() throws {
        // Arrange
        let input = #"[Google](https://www.google.com "great-url-title") test [Google](https://www.google.com "a11y title") and even more [https://www.apple.com](https://www.apple.com "Apple-title") test"#
        let markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        // Act
        let paragraphItem = markyMark.parseMarkDown(input).first

        // Assert
        let linkMarkDownItem1 = try XCTUnwrap(paragraphItem?.markDownItems?[0] as? LinkMarkDownItem)
        XCTAssertEqual(linkMarkDownItem1.content, "Google")
        XCTAssertEqual(linkMarkDownItem1.url, "https://www.google.com")
        XCTAssertEqual(linkMarkDownItem1.title, "great-url-title")

        let linkMarkDownItem2 = try XCTUnwrap(paragraphItem?.markDownItems?[2] as? LinkMarkDownItem)
        XCTAssertEqual(linkMarkDownItem2.content, "Google")
        XCTAssertEqual(linkMarkDownItem2.url, "https://www.google.com")
        XCTAssertEqual(linkMarkDownItem2.title, "a11y title")

        let linkMarkDownItem3 = try XCTUnwrap(paragraphItem?.markDownItems?[4] as? LinkMarkDownItem)
        XCTAssertEqual(linkMarkDownItem3.content, "https://www.apple.com")
        XCTAssertEqual(linkMarkDownItem3.url, "https://www.apple.com")
        XCTAssertEqual(linkMarkDownItem3.title, "Apple-title")
    }
}
