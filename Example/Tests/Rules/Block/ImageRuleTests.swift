//
//  Created by Maren Osnabrug on 10-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ImageRuleTests: XCTestCase {

    var sut: ImageRule!

    override func setUp() {
        super.setUp()
        sut = ImageRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["![Alt text](image.png)"]))
        XCTAssertTrue(sut.recognizesLines(["Lorem ipsum ![Alt text](image.png) (nothing)"]))
    }

    func testDoesNotRecognizesLines() {
        XCTAssertFalse((sut.recognizesLines(["[Alt text](image.png)"])))
        XCTAssertFalse((sut.recognizesLines(["!aaa[Alt text](image.png)"])))
        XCTAssertFalse((sut.recognizesLines(["![Alt text]gjhg(image.png)"])))
    }

    func testCreateMarkDownItemWithLinesCreatesCorrectItem() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["![Alt text](image.png)"])
        //Act

        //Assert
        XCTAssert(markDownItem is ImageMarkDownItem)
    }

    func testCreateMarkDownItemContainsCorrectImage() {
        //Arrange
        let markDownItem = sut.createMarkDownItemWithLines(["![Alt text](image.png)"])
        let markDownItem2 = sut.createMarkDownItemWithLines(["![Description](picture.jpeg)"])
        //Act

        //Assert
        XCTAssertEqual((markDownItem as! ImageMarkDownItem).altText, "Alt text")
        XCTAssertEqual((markDownItem as! ImageMarkDownItem).file, "image.png")
        XCTAssertEqual((markDownItem2 as! ImageMarkDownItem).altText, "Description")
        XCTAssertEqual((markDownItem2 as! ImageMarkDownItem).file, "picture.jpeg")
    }

    func testGetAllMatches() {
        //Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 22)
        let expectedMatchesRange2 = NSRange(location: 28, length: 22)
        //Act

        //Assert
        XCTAssertEqual(sut.getAllMatches(["![Alt text](image.png) (nothing)"]), [expectedMatchesRange])
        XCTAssertEqual(sut.getAllMatches(["![Alt text]"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["[Alt text](image.png)"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["(image.png)"]).count, 0)
        XCTAssertEqual(sut.getAllMatches(["![Alt text](image.png) test ![Alt text](image.png)"]), [expectedMatchesRange, expectedMatchesRange2])
    }
}
