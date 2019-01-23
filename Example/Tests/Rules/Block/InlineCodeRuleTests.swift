//
//  InlineCodeRuleTests.swift
//  MarkyMark
//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class InlineCodeRuleTests: XCTestCase {

    var sut: InlineCodeRule!

    override func setUp() {
        super.setUp()
        sut = InlineCodeRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["`Text`"]))
        XCTAssertFalse((sut.recognizesLines(["Code"])))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["`Text`"])
        //Act

        //Assert
        XCTAssert(markdownItem is InlineCodeMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectText() {
        //Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["`Text`"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["`Code`"])
        //Act

        //Assert
        XCTAssertEqual((markdownItem as! InlineCodeMarkDownItem).content, "Text")
        XCTAssertEqual((markdownItem2 as! InlineCodeMarkDownItem).content, "Code")
    }

    func testGetAllMatches() {
        //Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 6)
        let expectedMatchesRange2 = NSRange(location: 12, length: 6)
        //Act

        //Assert
        XCTAssertEqual(sut.getAllMatches(["`Text`"]), [expectedMatchesRange])
        XCTAssertEqual(sut.getAllMatches(["`Text"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["`Text` test `Text`"]), [expectedMatchesRange, expectedMatchesRange2])
    }
}
