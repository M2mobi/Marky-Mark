//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class InlineTextRuleTests: XCTestCase {

    var sut: InlineTextRule!

    override func setUp() {
        super.setUp()
        sut = InlineTextRule()
    }

    func testRecognizesLines() {
        XCTAssert(sut.recognizesLines(["Text"]))
        XCTAssert(sut.recognizesLines([""]))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["Text"])
        //Act

        //Assert
        XCTAssert(markDownItem is InlineTextMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectText() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["Text"])
        let markDownItem2 = sut.createMarkDownItemWithLines(["Text that is inline"])

        //Act

        //Assert
        XCTAssertEqual((markDownItem as! InlineTextMarkDownItem).content, "Text")
        XCTAssertEqual((markDownItem2 as! InlineTextMarkDownItem).content, "Text that is inline")
    }

    func testGetAllMatches() {
        //Arrange
        let expectedMatchesRange = [NSRange]()
        //Act

        //Assert
        XCTAssertEqual(sut.getAllMatches([]), expectedMatchesRange)
        XCTAssertEqual(sut.getAllMatches(["Text"]), expectedMatchesRange)
    }
}
