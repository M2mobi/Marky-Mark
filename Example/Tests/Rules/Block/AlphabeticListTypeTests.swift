//
//  Created by Maren Osnabrug on 26-05-16.
//  Copyright © 2016 M2Mobi. All rights reserved.
//

import XCTest
@testable import MarkyMark

class AlphabeticListTypeTests: XCTestCase {

    var sut:AlphabeticListType!

    override func setUp() {
        super.setUp()
        sut = AlphabeticListType()
    }

    func testPattern() {
        // Arrange
        let AlphabeticListPattern = "[a-zA-Z]\\."

        // Assert
        XCTAssertEqual(sut.pattern, AlphabeticListPattern)
    }

    func testGetIndex() {
        //Arrange
        let expected = sut.getIndex("b.")
        let expected1 = sut.getIndex("g.")
        let expected2 = sut.getIndex("l")
        let expected3 = sut.getIndex("m.")
        let expected4 = sut.getIndex("a.")

        let expectedFailure = sut.getIndex("- ")
        let expectedFailure1 = sut.getIndex("1.")

        //Act

        //Assert
        XCTAssertEqual(expected, 1)
        XCTAssertEqual(expected1, 6)
        XCTAssertEqual(expected2, 11)
        XCTAssertEqual(expected3, 12)
        XCTAssertEqual(expected4, 0)

        XCTAssertNil(expectedFailure)
        XCTAssertNil(expectedFailure1)
    }
}
