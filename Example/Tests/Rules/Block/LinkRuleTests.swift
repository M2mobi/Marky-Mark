//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class LinkRuleTests: XCTestCase {

    var sut: LinkRule!

    override func setUp() {
        super.setUp()
        sut = LinkRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["[Alt text](image.png)"]))
        XCTAssertFalse((sut.recognizesLines(["![Alt text](image.png)"])))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["[Google](http://www.google.com)"])
        //Act

        //Assert
        XCTAssert(markDownItem is LinkMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectLink() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["[Google](http://www.google.com)"])
        let markDownItem2 = sut.createMarkDownItemWithLines(["[Youtube](http://www.youtube.com)"])

        //Act

        //Assert
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).content, "Google")
        XCTAssertEqual((markDownItem as! LinkMarkDownItem).url, "http://www.google.com")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).content, "Youtube")
        XCTAssertEqual((markDownItem2 as! LinkMarkDownItem).url, "http://www.youtube.com")

    }

    func testGetAllMatches() {
        //Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 32)
        let expectedMatchesRange2 = NSRange(location: 38, length: 32)
        //Act

        //Assert
        XCTAssertEqual(sut.getAllMatches(["[Google](https://www.google.com)"]), [expectedMatchesRange])
        XCTAssertEqual(sut.getAllMatches(["(https://www.google.com)"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["[Google]"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["![Google](https://www.google.com)"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["[Google](https://www.google.com) test [Google](https://www.google.com)"]), [expectedMatchesRange, expectedMatchesRange2])
    }

}
