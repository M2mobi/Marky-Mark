//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import MarkyMark
/*
class AlphabeticallyOrderedListRuleTests: XCTestCase {

    var sut:AlphabeticallyOrderedListRule!

    override func setUp() {
        super.setUp()
        sut = AlphabeticallyOrderedListRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["b. List item"]))
        XCTAssertTrue(sut.recognizesLines(["y. List item"]))
        XCTAssertTrue(sut.recognizesLines(["A. List item", "c. Another list item"]))

        XCTAssertFalse(sut.recognizesLines(["- List item"]))
        XCTAssertFalse(sut.recognizesLines(["1. Another list item"]))

    }

    func testCreateMarkDownItemCreatesCorrectItem() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["b. List item"])

        //Assert
        XCTAssert(markdownItem is AlphabeticallyOrderedMarkDownItem)
    }

    func testCreatedMarkDownItemContainsCorrectText() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["b. List item"])

        //Assert
        XCTAssertEqual((markdownItem as! AlphabeticallyOrderedMarkDownItem).content, "List item")
    }

    func testLinesConsumed() {
        //Arrange
        let fakeLines = ["C. List item", "a. Another list item"]
        let fakeLines2 = ["A. List item", "b. Another list item", "c. Yes another list item"]
        //Act
        sut.recognizesLines(fakeLines)
        let actualLinesConsumed = sut.linesConsumed()
        sut.recognizesLines(fakeLines2)
        let actualLinesConsumed2 = sut.linesConsumed()
        //Assert
        XCTAssertEqual(actualLinesConsumed, fakeLines.count)
        XCTAssertEqual(actualLinesConsumed2, fakeLines2.count)
    }

    func testGetLevel() {
        //Arrange
        let fakeLine = "  g. List item"
        let fakeLine2 = "    h. List item"
        //Act
        let level = sut.getLevel(fakeLine)
        let level2 = sut.getLevel(fakeLine2)
        //Assert
        XCTAssertEqual(level, 1)
        XCTAssertEqual(level2, 2)
    }

    func testGetIndex() {
        //Arrange
        let fakeLine = "b. List item"
        let fakeLineG = "g. List item"
        let fakeLineY = "y. List item"
        //Assert
        XCTAssertEqual(sut.getIndex(fakeLine), 1)
        XCTAssertEqual(sut.getIndex(fakeLineG), 6)
        XCTAssertEqual(sut.getIndex(fakeLineY), 24)


    }

}
*/