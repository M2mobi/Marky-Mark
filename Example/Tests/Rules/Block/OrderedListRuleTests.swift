//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import MarkyMark

class OrderedListRuleTests: XCTestCase {

    var sut:OrderedListRule!

    override func setUp() {
        super.setUp()
        sut = OrderedListRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["1. List item"]))
        XCTAssertTrue(sut.recognizesLines(["  1. List item"]))
        XCTAssertTrue(sut.recognizesLines(["  1.List item"]))
        XCTAssertTrue(sut.recognizesLines(["1. List item", "2. Another list item"]))

        XCTAssertFalse(sut.recognizesLines(["y. List item"]))
        XCTAssertFalse(sut.recognizesLines(["- List item"]))
    }

    func testCreateMarkDownItemCreatesCorrectItem() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["1. List item"])

        //Assert
        XCTAssert(markdownItem is OrderedListMarkDownItem)
    }

    func testCreatedMarkDownItemContainsCorrectText() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["1. List item"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["7.List item"])

        //Assert
        XCTAssertEqual((markdownItem as! OrderedListMarkDownItem).content, "List item")
        XCTAssertEqual((markdownItem2 as! OrderedListMarkDownItem).content, "List item")
    }

    func testLinesConsumed() {
        //Arrange
        let fakeLines = ["1. List item", "2.Another list item"]
        let fakeLines2 = ["3. List item", "2. Another list item", "1. Yes another list item"]
        //Act
        sut.recognizesLines(fakeLines)
        let actualLinesConsumed = sut.linesConsumed()
        sut.recognizesLines(fakeLines2)
        let actualLinesConsumed2 = sut.linesConsumed()
        //Assert
        XCTAssertEqual(actualLinesConsumed, fakeLines.count)
        XCTAssertEqual(actualLinesConsumed2, fakeLines2.count)
    }

    func testGetIndex() {
        //Arrange
        let fakeLine = "1. List item"
        let fakeLine2 = "2. List item"
        let fakeLine3 = "3.List item"
        let fakeLine10 = "11. List item"

        //Assert
        XCTAssertEqual(sut.getIndex(fakeLine), 1)
        XCTAssertEqual(sut.getIndex(fakeLine2), 2)
        XCTAssertEqual(sut.getIndex(fakeLine3), 3)
        XCTAssertEqual(sut.getIndex(fakeLine10), 11)

    }

    func testGetLevel() {
        //Arrange
        let fakeLine = "  9.List item"
        let fakeLine2 = "      10. List item"
        //Act
        let level = sut.getLevel(fakeLine)
        let level2 = sut.getLevel(fakeLine2)
        //Assert
        XCTAssertEqual(level, 1)
        XCTAssertEqual(level2, 3)
    }

}
