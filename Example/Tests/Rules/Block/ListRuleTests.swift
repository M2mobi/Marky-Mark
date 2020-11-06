//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ListRuleTests: XCTestCase {

    var sut: ListRule!

    override func setUp() {
        super.setUp()
        sut = ListRule(listTypes: [FakeListType()])
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["- List item"]))
        XCTAssertTrue(sut.recognizesLines(["-    List item"]))
        XCTAssertTrue(sut.recognizesLines(["  - List item"]))
        XCTAssertTrue(sut.recognizesLines(["  -    List item"]))
        XCTAssertTrue(sut.recognizesLines(["- List item", "- Another list item"]))
        XCTAssertTrue(sut.recognizesLines(["^-^ List item"]))

        XCTAssertFalse(sut.recognizesLines(["A. List item"]))
        XCTAssertFalse(sut.recognizesLines(["1. Another list item"]))
    }
   
    func testCreateMarkDownItemCreatesCorrectItem() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["- List item"])
        let markdownItemFake = sut.createMarkDownItemWithLines(["^-^ List item"])

        //Assert
        XCTAssert(markdownItem is ListMarkDownItem)
        XCTAssert(markdownItemFake is FakeListMarkDownItem)
    }

    func testCreatedMarkDownItemContainsCorrectText() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["- List item"])
        let markdownItemFake = sut.createMarkDownItemWithLines(["^-^ List item"])

        //Assert
        XCTAssertEqual((markdownItem as! ListMarkDownItem).content, "List item")
        XCTAssertEqual((markdownItemFake as! FakeListMarkDownItem).content, "List item")

    }

    func testCreatedMarkDownItemWithMultipleWhitespacesContainsCorrectText() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["-    List item"])

        //Assert
        XCTAssertEqual((markdownItem as! ListMarkDownItem).content, "List item")
    }

    func testLinesConsumed() {
        //Arrange
        let fakeLines = ["^-^ List item", "- Another list item"]
        let fakeLines2 = ["- List item", "^-^ Another list item", "- Yes another list item"]

        //Act
        _ = sut.recognizesLines(fakeLines)
        let actualLinesConsumed = sut.linesConsumed()
        _ = sut.recognizesLines(fakeLines2)
        let actualLinesConsumed2 = sut.linesConsumed()

        //Assert
        XCTAssertEqual(actualLinesConsumed, fakeLines.count)
        XCTAssertEqual(actualLinesConsumed2, fakeLines2.count)
    }

    func testGetLevel() {
        //Arrange
        let fakeLine = "  - List item"
        let fakeLine2 = "    ^-^ List item"

        //Act
        let level = sut.getLevel(fakeLine)
        let level2 = sut.getLevel(fakeLine2)

        //Assert
        XCTAssertEqual(level, 1)
        XCTAssertEqual(level2, 2)
    }

}

class FakeListType: ListType {

    var pattern: String { return "\\^\\-\\^" }

    var relatedListMarkDownType: ListMarkDownItem.Type { return FakeListMarkDownItem.self }

    func getIndex(_ stringIndex: String) -> Int? {
        return stringIndex == "^-^" ? 1 : nil
    }
}

class FakeListMarkDownItem: ListMarkDownItem {

}
