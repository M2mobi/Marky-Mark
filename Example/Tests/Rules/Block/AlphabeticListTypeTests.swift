//
//  Created by Maren Osnabrug on 26-05-16.
//  Copyright © 2016 M2Mobi. All rights reserved.
//

import XCTest
@testable import markymark

class AlphabeticListTypeTests: XCTestCase {

    var sut: AlphabeticListType!

    override func setUp() {
        super.setUp()
        sut = AlphabeticListType()
    }

    func testPattern() {
        // Arrange
        let alphabeticListPattern = "[a-zA-Z]\\."

        // Assert
        XCTAssertEqual(sut.pattern, alphabeticListPattern)
    }

    func testGetIndex() {

        //Assert
        XCTAssertEqual(sut.getIndex("b."), 1)
        XCTAssertEqual(sut.getIndex("g."), 6)
        XCTAssertEqual(sut.getIndex("l"), 11)
        XCTAssertEqual(sut.getIndex("m."), 12)
        XCTAssertEqual(sut.getIndex("a."), 0)

        XCTAssertNil(sut.getIndex("- "))
        XCTAssertNil(sut.getIndex("1."))
    }
}
