//
//  Created by Edwin on 05/01/2021.
//  Copyright © 2021 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class TitledLinkRuleTests: XCTestCase {

    private var sut = TitledLinkRule()

    func test_RecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["[Alt text](image.png)"]))
        XCTAssertTrue(sut.recognizesLines([#"[Alt text](image.png "some title")"#]))
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

    func test_GetAllMatches_When_ValidInput() {
        // Assert
        XCTAssertEqual(
            sut.getAllMatches(["[Google](https://www.google.com)"]),
            [
                NSRange(location: 0, length: 32)
            ]
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
