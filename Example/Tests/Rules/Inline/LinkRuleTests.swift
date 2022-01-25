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

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        // Act
        let markDownItem = sut.createMarkDownItemWithLines(["[Google](http://www.google.com)"])

        // Assert
        XCTAssert(markDownItem is LinkMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectLink() {
        // Act
        let markDownItem = sut.createMarkDownItemWithLines(["[Google](http://www.google.com)"])
        let markDownItem2 = sut.createMarkDownItemWithLines(["[Youtube](http://www.youtube.com)"])

        // Assert
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).content, "Google")
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).url, "http://www.google.com")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).content, "Youtube")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).url, "http://www.youtube.com")
    }

    func testCreateMarkDownItemContainsCorrectLinkWhenUsingAriaLabel() {
        // Act
        let markDownItem = sut.createMarkDownItemWithLines([#"[Google](http://www.google.com "Google")"#])
        let markDownItem2 = sut.createMarkDownItemWithLines([#"[Youtube](http://www.youtube.com "You-tube")"#])

        // Assert
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).content, "Google")
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).url, "http://www.google.com")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).content, "Youtube")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).url, "http://www.youtube.com")
    }

    func testGetAllMatches() {
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

        XCTAssertEqual(
            sut.getAllMatches([#"[Google](https://www.google.com) test [Google](https://www.google.com "a11y title")"#]),
            [
                NSRange(location: 0, length: 32),
                NSRange(location: 38, length: 45)
            ]
        )
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
}
