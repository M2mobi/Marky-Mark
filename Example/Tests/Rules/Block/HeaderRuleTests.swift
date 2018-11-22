//
//  Created by Jim van Zummeren on 27/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class HeaderRuleTests: XCTestCase {

    var sut: HeaderRule!

    override func setUp() {
        super.setUp()
        sut = HeaderRule()
    }

    func testHeaderRuleRecognizesHeaderMarkDown() {
        XCTAssert(sut.recognizesLines(["# Text"]))
        XCTAssert(sut.recognizesLines(["## Text"]))
        XCTAssert(sut.recognizesLines(["### Text"]))
        XCTAssert(sut.recognizesLines(["#### Text"]))
        XCTAssert(sut.recognizesLines(["##### Text"]))
        XCTAssert(sut.recognizesLines(["###### Text"]))
    }

    func testHeaderRuleDoesNotRecognizeOtherMarkDown() {
        XCTAssertFalse(sut.recognizesLines(["#Text"]))
        XCTAssertFalse(sut.recognizesLines(["Text"]))
        XCTAssertFalse(sut.recognizesLines(["A# Text"]))
        XCTAssertFalse(sut.recognizesLines(["####### Text"]))
    }

    func testCreateMarkDownItemCreatesCorrectItem() {
        //Act
        let markDownItem = sut.createMarkDownItemWithLines(["# Text"])

        //Assert
        XCTAssert(markDownItem is HeaderMarkDownItem)
    }

    func testCreatedMarkDownItemContainsCorrectText() {
        //Act
        let markDownItem = sut.createMarkDownItemWithLines(["# Text"])

        //Assert
        XCTAssertEqual((markDownItem as! HeaderMarkDownItem).content, "Text")
    }
}
