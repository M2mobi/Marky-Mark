//
//  Created by Jim van Zummeren on 28/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest

@testable import markymark

class HeaderMarkDownItemTests: XCTestCase {

    private var sut: HeaderMarkDownItem!

    override func setUp() {
        super.setUp()
        sut = HeaderMarkDownItem(lines: ["Line one"], content: "Line one", level: 1)
    }

    func testMarkDownItemHasCorrectText() {
        XCTAssertEqual(sut.content, "Line one")
    }

    func testMarkDownItemHasCorrectLines() {
        XCTAssertEqual(sut.lines, ["Line one"])
    }
}
