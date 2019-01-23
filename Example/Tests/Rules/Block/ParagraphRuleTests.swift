//
// Created by Jim van Zummeren on 28/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ParagraphRuleTests: XCTestCase {

    var sut: ParagraphRule!

    override func setUp() {
        super.setUp()
        sut = ParagraphRule()
    }

    func testParagraphAlwaysRecognizesLines() {
        XCTAssert(sut.recognizesLines(["Text"]))
        XCTAssert(sut.recognizesLines(["    Text"]))
        XCTAssert(sut.recognizesLines(["# Text"]))
    }

    func testCreateMarkDownItemCreatesCorrectItem() {
        //Act
        let markDownItem = sut.createMarkDownItemWithLines(["Text"])

        //Assert
        XCTAssert(markDownItem is ParagraphMarkDownItem)
    }

    func testCreatedMarkDownItemContainsCorrectText() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["Text"])

        //Assert
        XCTAssertEqual((markDownItem as! ParagraphMarkDownItem).content, "Text")
    }
}
