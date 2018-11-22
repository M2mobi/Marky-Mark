//
//  Created by Maren Osnabrug on 26-05-16.
//  Copyright © 2016 M2Mobi. All rights reserved.
//

import XCTest
@testable import markymark

class OrderedListTypeTests: XCTestCase {

    var sut: OrderedListType!

    override func setUp() {
        super.setUp()
        sut = OrderedListType()
    }

    func testPattern() {
        // Arrange
        let orderedListPattern = "\\d\\."

        // Assert
        XCTAssertEqual(sut.pattern, orderedListPattern)
    }

    func testGetIndex() {
        //Arrange
        let expected = sut.getIndex("2.")
        let expected1 = sut.getIndex("6.")
        let expected2 = sut.getIndex("9.")
        let expected3 = sut.getIndex("4.")
        let expected4 = sut.getIndex("12.")

        let expectedFailure = sut.getIndex("- ")
        let expectedFailure1 = sut.getIndex("a.")

        //Assert
        XCTAssertEqual(expected, 2)
        XCTAssertEqual(expected1, 6)
        XCTAssertEqual(expected2, 9)
        XCTAssertEqual(expected3, 4)
        XCTAssertEqual(expected4, 12)

        XCTAssertNil(expectedFailure)
        XCTAssertNil(expectedFailure1)
    }
}
