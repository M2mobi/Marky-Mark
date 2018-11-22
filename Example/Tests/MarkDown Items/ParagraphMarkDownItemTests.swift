//
//  Created by Jim van Zummeren on 28/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ParagraphMarkDownItemTests: XCTestCase {

    private var sut: ParagraphMarkDownItem!

    override func setUp() {
        super.setUp()
        sut = ParagraphMarkDownItem(lines: ["Line one"], content: "Line one")
    }

    func testMarkDownItemHasCorrectText() {
        XCTAssertEqual(sut.content, "Line one")
    }

    func testMarkDownItemHasCorrectLines() {
        XCTAssertEqual(sut.lines, ["Line one"])
    }
}
