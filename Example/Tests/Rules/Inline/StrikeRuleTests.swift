//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class StrikeRuleTests: XCTestCase {

    var sut: StrikeRule!

    override func setUp() {
        super.setUp()
        sut = StrikeRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["~~Text~~"]))
        XCTAssertFalse((sut.recognizesLines(["~Text~"])))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["~~Text~~"])
        //Act

        //Assert
        XCTAssert(markDownItem is StrikeMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectText() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["~~Text~~"])
        let markDownItem2 = sut.createMarkDownItemWithLines(["~~Text with a strike~~"])
        //Act

        //Assert
        XCTAssertEqual((markDownItem as! StrikeMarkDownItem).content, "Text")
        XCTAssertEqual((markDownItem2 as! StrikeMarkDownItem).content, "Text with a strike")
    }

    func testGetAllMatches() {
        //Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 8)
        let expectedMatchesRange2 = NSRange(location: 14, length: 8)
        //Act

        //Assert
        XCTAssertEqual(sut.getAllMatches(["~~Text~~"]), [expectedMatchesRange])
        XCTAssertEqual(sut.getAllMatches(["~Text~"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["~~Text~~ test ~~Text~~"]), [expectedMatchesRange, expectedMatchesRange2])
    }

}
