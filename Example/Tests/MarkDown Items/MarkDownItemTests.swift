//
//  Created by Jim van Zummeren on 28/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class MarkDownItemTests: XCTestCase {

    private var sut: MarkDownItem!

    override func setUp() {
        super.setUp()
        sut = MarkDownItem(lines: ["Line 1", "Line 2"], content: "")
    }

    func testMarkDownItemHasCorrectLines() {
        XCTAssertEqual(sut.lines, ["Line 1", "Line 2"])
    }
}
