//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import MarkyMark

 class ListRuleTests: XCTestCase {

     var sut:ListRule!

     override func setUp() {
         super.setUp()
         sut = ListRule(listTypes:[])
     }

     func testRecognizesLines() {
         XCTAssertTrue(sut.recognizesLines(["- List item"]))
         XCTAssertTrue(sut.recognizesLines(["  - List item"]))
         XCTAssertTrue(sut.recognizesLines(["- List item", "- Another list item"]))

         XCTAssertFalse(sut.recognizesLines(["A. List item"]))
         XCTAssertFalse(sut.recognizesLines(["1. Another list item"]))
     }

     func testCreateMarkDownItemCreatesCorrectItem() {
         //Act
         let markdownItem = sut.createMarkDownItemWithLines(["- List item"])

         //Assert
         XCTAssert(markdownItem is UnorderedListMarkDownItem)
         }

         func testCreatedMarkDownItemContainsCorrectText() {
         //Act
         let markdownItem = sut.createMarkDownItemWithLines(["- List item"])

         //Assert
         XCTAssertEqual((markdownItem as! UnorderedListMarkDownItem).content, "List item")
     }

     func testLinesConsumed() {
     //Arrange
         let fakeLines = ["- List item", "- Another list item"]
         let fakeLines2 = ["- List item", "- Another list item", "- Yes another list item"]
         //Act
         sut.recognizesLines(fakeLines)
         let actualLinesConsumed = sut.linesConsumed()
         sut.recognizesLines(fakeLines2)
         let actualLinesConsumed2 = sut.linesConsumed()
         //Assert
         XCTAssertEqual(actualLinesConsumed, fakeLines.count)
         XCTAssertEqual(actualLinesConsumed2, fakeLines2.count)
     }

     func testGetLevel() {
         //Arrange
         let fakeLine = "  - List item"
         let fakeLine2 = "    - List item"
         //Act
         let level = sut.getLevel(fakeLine)
         let level2 = sut.getLevel(fakeLine2)
         //Assert
         XCTAssertEqual(level, 1)
         XCTAssertEqual(level2, 2)
     }

 }