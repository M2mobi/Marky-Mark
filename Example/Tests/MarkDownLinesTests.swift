//
//  MarkDownLinesTests.swift
//  MarkyMark
//
//  Created by Jim van Zummeren on 26/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class MarkDownLinesTests: XCTestCase {

    var sut: MarkDownLines!

    override func setUp() {
        super.setUp()
        sut = MarkDownLines("Line one\nLine Two\nLineThree")
    }

    func testNumberOfLinesReturnsCorrectAmount() {
        //Arrange
        let expectedNumberOfLines = 3

        //Assert
        XCTAssertEqual(sut.numberOfLines(), expectedNumberOfLines)
    }

    func testIsEmptyReturnsTrueWhenNoLines() {
        //Arrange
        sut.lines = []

        //Assert
        XCTAssertEqual(sut.isEmpty(), true)
    }

    func testIsEmptyReturnsFalseWhenNotEmpty() {
        //Arrange
        sut.lines = ["Text"]

        //Assert
        XCTAssertEqual(sut.isEmpty(), false)
    }
}

private class MockRule: Rule {

    func recognizesLines(_ lines: [String]) -> Bool {
        return true
    }

    func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        return MockMarkDownItem(lines: lines, content: lines.first ?? "")
    }

    func linesConsumed() -> Int {
        return 2
    }
}

private class MockMarkDownItem: MarkDownItem {

}
