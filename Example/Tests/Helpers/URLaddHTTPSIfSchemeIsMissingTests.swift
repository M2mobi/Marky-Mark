//
//  URLaddHTTPSIfSchemeIsMissingTests.swift
//  markymark_Example
//
//  Created by Jim van Zummeren on 23/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import markymark

class URLaddHTTPSIfSchemeIsMissingTests: XCTestCase {

    func testSchemeWillNOTBeModifiedWhenPassingURLWithScheme() {
        // Arrange
        let url = URL(string: "http://www.google.com")!

        // Act
        let modifiedURL = url.addHTTPSIfSchemeIsMissing()

        // Assert
        XCTAssertEqual(modifiedURL.absoluteString, "http://www.google.com")
    }

    func testHTTPSSchemeWillBeAddedwhenPassingURLWithoutScheme() {
        // Arrange
        let url = URL(string: "//www.google.com")!

        // Act
        let modifiedURL = url.addHTTPSIfSchemeIsMissing()

        // Assert
        XCTAssertEqual(modifiedURL.absoluteString, "https://www.google.com")
    }
}
