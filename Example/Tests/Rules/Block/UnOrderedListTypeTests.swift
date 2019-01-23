//
//  Created by Maren Osnabrug on 26-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class UnOrderedListTypeTests: XCTestCase {

    var sut: UnOrderedListType!

    override func setUp() {
        super.setUp()
        sut = UnOrderedListType()
    }

    func testPattern() {
        // Arrange
        let unOrderedListPattern = "\\-|\\+|\\*"

        // Assert
        XCTAssertEqual(sut.pattern, unOrderedListPattern)
    }

    func testGetIndex() {
        //Arrange
        let expected = sut.getIndex("-")
        let expected1 = sut.getIndex("+")
        let expected2 = sut.getIndex("*")

        let expectedFailure = sut.getIndex("1.")
        let expectedFailure1 = sut.getIndex("a.")

        //Assert
        XCTAssertEqual(expected, nil)
        XCTAssertEqual(expected1, nil)
        XCTAssertEqual(expected2, nil)

        XCTAssertNil(expectedFailure)
        XCTAssertNil(expectedFailure1)
    }

}
