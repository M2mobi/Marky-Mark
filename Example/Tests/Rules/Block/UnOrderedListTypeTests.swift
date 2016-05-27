//
//  Created by Maren Osnabrug on 26-05-16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import MarkyMark

class UnOrderedListTypeTests: XCTestCase {

    var sut:UnOrderedListType!

    override func setUp() {
        super.setUp()
        sut = UnOrderedListType()
    }

    func testPattern() {
        // Arrange
        let UnOrderedListPattern = "\\-|\\+|\\*"

        // Assert
        XCTAssertEqual(sut.pattern, UnOrderedListPattern)
    }

    func testGetIndex() {
        //Arrange
        let expected = sut.getIndex("-")
        let expected1 = sut.getIndex("+")
        let expected2 = sut.getIndex("*")

        let expectedFailure = sut.getIndex("1.")
        let expectedFailure1 = sut.getIndex("a.")

        //Act

        //Assert
        XCTAssertEqual(expected,nil)
        XCTAssertEqual(expected1,nil)
        XCTAssertEqual(expected2,nil)

        XCTAssertNil(expectedFailure)
        XCTAssertNil(expectedFailure1)
    }

}
