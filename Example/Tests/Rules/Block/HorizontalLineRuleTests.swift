//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class HorizontalLineRuleTests: XCTestCase {

    var sut: HorizontalLineRule!

    override func setUp() {
        super.setUp()
        sut = HorizontalLineRule()
    }

    func testcreateMarkDownItemWithLinesCreatesCorrectItem() {
        // Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["---"])

        // Assert
        XCTAssert(markdownItem is HorizontalLineMarkDownItem)
    }

    func testcreateMarkDownItemWithLinesContainsCorrectText() {
        // Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["---"])

        // Assert
        XCTAssertEqual((markdownItem as! HorizontalLineMarkDownItem).lines, ["---"])
    }

    func testRecognizesLines() {
        XCTAssert(sut.recognizesLines(["---"]))
        XCTAssertFalse(sut.recognizesLines(["--"]))
    }
}
