//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class BoldRuleTests: XCTestCase {

    var sut: BoldRule!

    override func setUp() {
        super.setUp()
        sut = BoldRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["**Text**"]))
        XCTAssertFalse((sut.recognizesLines(["*Text*"])))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["**Text**"])
        //Act

        //Assert
        XCTAssert(markdownItem is BoldMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectText() {
        //Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["**Text**"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["**Text that is BOLD**"])
        //Act

        //Assert
        XCTAssertEqual((markdownItem as! BoldMarkDownItem).content, "Text")
        XCTAssertEqual((markdownItem2 as! BoldMarkDownItem).content, "Text that is BOLD")
    }

    func testGetAllMatches() {
        //Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 8)
        let expectedMatchesRange2 = NSRange(location: 14, length: 8)
        //Act

        //Assert
        XCTAssertEqual(sut.getAllMatches(["**Text**"]), [expectedMatchesRange])
        XCTAssertEqual(sut.getAllMatches(["*Text*"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["**Text** test **Text**"]), [expectedMatchesRange, expectedMatchesRange2])
    }
}
