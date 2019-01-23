//
//  MarkyMarkTests.swift
//  MarkyMarkTests
//
//  Created by Pear on 22/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class MarkyMarkTests: XCTestCase {

    var sut: MarkyMark!

    override func setUp() {
        super.setUp()

        sut = MarkyMark(build: {
            $0.setDefaultRule(MockNeverRecognizeRule())
            $0.setDefaultInlineRule(InlineTextRule())
        })
    }

    func testSetDefaultRuleIsReturnedAsDefaultByGetRuleForLines() {
        //Arrange
        let expectedDefaultRule = MockAlwaysRecognizeRule()

        //Act
        sut.addRule(MockNeverRecognizeRule())
        sut.addRule(MockNeverRecognizeRule())
        sut.setDefaultRule(expectedDefaultRule)

        //Assert
        XCTAssert((sut.getRuleForLines([]) as AnyObject) === expectedDefaultRule)
    }

    func testAddRuleEndsUpInAllRules() {
        //Arrange
        let expectedNumberOfRules = 2

        //Act
        sut.addRule(MockAlwaysRecognizeRule())
        sut.addRule(MockAlwaysRecognizeRule())

        //Assert
        XCTAssertEqual(sut.allRules().count, expectedNumberOfRules)
    }

    func testSetFlavorEndsUpInAllRules() {
        //Arrange
        let expectedNumberOfRules = 3
        let expectedNumberOfInlineRules = 2

        //Act
        sut.setFlavor(MockFlavor())

        //Assert
        XCTAssertEqual(sut.allRules().count, expectedNumberOfRules)
        XCTAssertEqual(sut.allInlineRules().count, expectedNumberOfInlineRules)
    }

    func testGetRuleForLinesReturnLineForAddedRule() {
        //Arrange
        let rule = MockTestRule()
        sut.addRule(rule)

        //Act

        //Assert
        XCTAssert((sut.getRuleForLines(["Test"]) as AnyObject) === rule)
    }

    func testParseMarkDownReturnsCorrectMarkDownItems() {
        //Arrange
        let markDown = "Line one\nLine Two\n# Line three"
        sut.addRule(MockNeverRecognizeRule())
        sut.addRule(MockAlwaysRecognizeRule())

        //Act
        let markDownItems = sut.parseMarkDown(markDown)

        //Assert
        XCTAssert(markDownItems[0] is MockMarkDownItem)
        XCTAssert(markDownItems[1] is MockMarkDownItem)
        XCTAssert(markDownItems[2] is MockMarkDownItem)
    }

    func testParseMarkDownReturnsCorrectNumberOfMarkDownItems() {
        //Arrange
        let markDown = "Line one\nLine Two\n# Line three\n Line Four"
        sut.addRule(MockAlwaysRecognizeRule())

        let expectedNumberOfMarkDownItems = 4

        //Act
        let markDownItems = sut.parseMarkDown(markDown)

        //Assert
        XCTAssertEqual(markDownItems.count, expectedNumberOfMarkDownItems)
    }

    func testParseMarkDownReturnsMarkDownItemsWithCorrectLines() {
        //Arrange
        let markDown = "Line one\nLine two\nLine three"
        sut.addRule(MockAlwaysRecognizeRule())

        //Act
        let markDownItems = sut.parseMarkDown(markDown)

        //Assert
        XCTAssertEqual(markDownItems[0].lines, ["Line one"])
        XCTAssertEqual(markDownItems[1].lines, ["Line two"])
        XCTAssertEqual(markDownItems[2].lines, ["Line three"])
    }
}

private class MockTestRule: Rule {

    func recognizesLines(_ lines: [String]) -> Bool {
        guard let line = lines.first else { return false }
        return line == "Test"
    }

    func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        return MockMarkDownItem(lines: lines, content: lines.first ?? "")
    }
}

private class MockAlwaysRecognizeRule: Rule {

    func recognizesLines(_ lines: [String]) -> Bool {
        return true
    }

    func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        return MockMarkDownItem(lines: lines, content: lines.first ?? "")
    }
}

private class MockNeverRecognizeRule: Rule {

    func recognizesLines(_ lines: [String]) -> Bool {
        return false
    }

    func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        return MockWrongMarkDownItem(lines: lines, content: lines.first ?? "")
    }
}

private class MockNeverRecognizeInlineRule: InlineRule {

    func recognizesLines(_ lines: [String]) -> Bool {
        return false
    }

    func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        return MockWrongMarkDownItem(lines: lines, content: lines.first ?? "")
    }

    func getAllMatches(_ lines: [String]) -> [NSRange] {
        return []
    }
}

private class MockMarkDownItem: MarkDownItem {

}

private class MockWrongMarkDownItem: MarkDownItem {

}

private class MockFlavor: Flavor {

    var rules: [Rule]
    var inlineRules: [InlineRule]
    var defaultRule: Rule = ParagraphRule()
    var defaultInlineRule: InlineRule = InlineTextRule()
    init () {
        self.rules = [ParagraphRule(), ParagraphRule(), ParagraphRule()]
        self.inlineRules = [MockNeverRecognizeInlineRule(), MockNeverRecognizeInlineRule()]
    }

}
