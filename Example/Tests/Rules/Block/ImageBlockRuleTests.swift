//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ImageBlockRuleTests: XCTestCase {

    var sut: ImageBlockRule!

    override func setUp() {
        super.setUp()
        sut = ImageBlockRule()
    }

    func testcreateMarkDownItemWithLinesCreatesCorrectItem() {
        // Arrange
		let markdownItem = sut.createMarkDownItemWithLines(["![Alt text](image.png)"])

		// Assert
		XCTAssert(markdownItem is ImageBlockMarkDownItem)
    }

    func testcreateMarkDownItemWithLinesContainsCorrectText() {
        // Arrange
        let markdownItem = sut.createMarkDownItemWithLines(["![Alt text](image.png)"])

        // Assert
        XCTAssertEqual((markdownItem as! ImageBlockMarkDownItem).altText, "Alt text")
        XCTAssertEqual((markdownItem as! ImageBlockMarkDownItem).file, "image.png")
    }

    func testRecognizesLines() {
        XCTAssert(sut.recognizesLines(["![Alt text](image.png)"]))
        XCTAssert(sut.recognizesLines(["![Alt text](picture.jpeg)"]))

        XCTAssertFalse(sut.recognizesLines(["![Alt text]"]))
        XCTAssertFalse(sut.recognizesLines(["(image.png)"]))
        XCTAssertFalse(sut.recognizesLines(["[Google](http://www.google.com)"]))

    }
}
