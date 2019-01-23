//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class BlockQuoteRuleTests: XCTestCase {

    var sut: BlockQuoteRule!

    override func setUp() {
        super.setUp()
        sut = BlockQuoteRule()
    }

    func testcreateMarkDownItemWithLinesCreatesCorrectItem() {
        // Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["> Quote"])

        // Assert
        XCTAssert(markdownItem is QuoteMarkDownItem)
    }

    func testcreateMarkDownItemWithLinesContainsCorrectText() {
        // Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["> Quote"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["> Text"])

        // Assert
        XCTAssertEqual((markdownItem as! QuoteMarkDownItem).content, "Quote")
        XCTAssertEqual((markdownItem2 as! QuoteMarkDownItem).content, "Text")
    }

    func testRecognizesLines() {
        XCTAssert(sut.recognizesLines(["> Quote"]))
        XCTAssertFalse(sut.recognizesLines(["\"Quote\""]))
    }
}
