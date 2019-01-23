//
//  Created by Maren Osnabrug on 11-05-16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class CodeBlockRuleTests: XCTestCase {

    var sut: CodeBlockRule!

    override func setUp() {
        super.setUp()
        sut = CodeBlockRule()
    }

    func testRecognizesLines() {
        XCTAssertTrue(sut.recognizesLines(["```Code block```"]))
        XCTAssertTrue(sut.recognizesLines(["```Code block```", "```Code block```"]))

        XCTAssertFalse(sut.recognizesLines(["``Code block``"]))
        XCTAssertFalse(sut.recognizesLines(["```Code block"]))

    }

    func testCreateMarkDownItemCreatesCorrectItem() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["```Code block```"])

        //Assert
        XCTAssert(markdownItem is CodeBlockMarkDownItem)
    }

    func testCreatedMarkDownItemContainsCorrectText() {
        //Act
        let markdownItem = sut.createMarkDownItemWithLines(["```Code block```"])
        let markdownItem2 = sut.createMarkDownItemWithLines(["```This should end up as code```"])

        //Assert
        XCTAssertEqual((markdownItem as! CodeBlockMarkDownItem).content, "Code block")
        XCTAssertEqual((markdownItem2 as! CodeBlockMarkDownItem).content, "This should end up as code")

    }

}
