//
//  Created by Maren Osnabrug on 27-05-16.
//  Copyright © 2016 M2Mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ListRuleIntegrationTests: XCTestCase {

    var sut:ListRule!

    override func setUp() {
        super.setUp()
        sut = ListRule(listTypes: [AlphabeticListType(), OrderedListType()])
    }

    func testRecognizesLines() {
        // Arrange
        let markDownString = "- Hello"
            + "- Hello"
            + "  1. Hello"
            + "  2. Hello"
            + "    a. Hello"
            + "    b. Hello"
            + "    c. Hello"
            + "      - Hello"
            + "- Hello"

        //Assert
        XCTAssert(sut.recognizesLines(["- Donec"]))
        XCTAssert(sut.recognizesLines(["1. Fusce ullamcorper"]))
        XCTAssert(sut.recognizesLines(["a. Cras vitae"]))
        XCTAssert(sut.recognizesLines(["- Etiam", "1. Nulla", "a. Quisque"]))
        XCTAssert(sut.recognizesLines([markDownString]))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["- Curabitur"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["4. Lorem"])
        let markdownItem3 = sut.createMarkDownItemWithLines(["g. Ipsum"])
        let combinedMarkDownItems = sut.createMarkDownItemWithLines(["- Consectetur","- Adipiscing","5. Elit"])
        let combinedMarkDownItems2 = sut.createMarkDownItemWithLines(["A. Praesent","4. Aenean","- In Augue"])
        let combinedMarkDownItems3 = sut.createMarkDownItemWithLines(["9. Suspendisse","- Duis","C. Aliquam"])

        //Assert
        XCTAssert(markdownItem is ListMarkDownItem)
        XCTAssert(markdownItem2 is OrderedListMarkDownItem)
        XCTAssert(markdownItem3 is AlphabeticallyOrderedMarkDownItem)
        XCTAssert(combinedMarkDownItems is UnorderedListMarkDownItem)
        XCTAssert(combinedMarkDownItems2 is AlphabeticallyOrderedMarkDownItem)
        XCTAssert(combinedMarkDownItems3 is OrderedListMarkDownItem)
    }

    func testCreateMarkDownItemWithLinesContainsCorrectText() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["- Vestibulum"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["8. Vivamus"])
        let markdownItem3 = sut.createMarkDownItemWithLines(["B. Integer"])

        //Assert
        XCTAssertEqual((markdownItem as! ListMarkDownItem).content, "Vestibulum")
        XCTAssertEqual((markdownItem2 as! OrderedListMarkDownItem).content, "Vivamus")
        XCTAssertEqual((markdownItem3 as! AlphabeticallyOrderedMarkDownItem).content, "Integer")
    }

    func testLinesConsumed() {
        // Arrange
        let fakeLines = ["- List item", "- Another list item"]
        let fakeLines2 = ["- List item", "1. Another list item", "a. Yes another list item"]
        let fakeLines3 = ["- Hello", "- Hello","  1. Hello", "  2. Hello","    a. Hello", "    b. Hello", "    c. Hello", "      - Hello", "- Hello"]
        // Act
        sut.recognizesLines(fakeLines)
        let actualLinesConsumed = sut.linesConsumed()
        sut.recognizesLines(fakeLines2)
        let actualLinesConsumed2 = sut.linesConsumed()
        sut.recognizesLines(fakeLines3)
        let actualLinesConsumedLong = sut.linesConsumed()
        // Assert
        XCTAssertEqual(actualLinesConsumed, fakeLines.count)
        XCTAssertEqual(actualLinesConsumed2, fakeLines2.count)
        XCTAssertEqual(actualLinesConsumedLong, fakeLines3.count)
    }

    func testGetLevel() {
        //Arrange
        let fakeLine = "  - List item"
        let fakeLine2 = "    1. List item"
        let fakeLine3 = "a. List item"
        //Act
        let level = sut.getLevel(fakeLine)
        let level2 = sut.getLevel(fakeLine2)
        let level3 = sut.getLevel(fakeLine3)
        //Assert
        XCTAssertEqual(level, 1)
        XCTAssertEqual(level2, 2)
        XCTAssertEqual(level3, 0)
    }
}
