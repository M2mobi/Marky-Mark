//
//  Created by Jim van Zummeren on 28/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import XCTest
@testable import MarkyMark
/*
class MarkDownConverterTests: XCTestCase {

    var sut:MarkDownConverter = MarkDownConverter(configuration: MarkDownMockConverterConfiguration())

    func testConvertReturnsCorrectNumberOfItems() {
        //Arrange
        let markDownItem = MockMarkDownItem(lines: [""], content: "")

        //Act
        let strings = sut.convert([markDownItem, markDownItem, markDownItem, markDownItem])

        //Assert
        XCTAssertEqual(strings.count, 4)
    }

    func testConvertCreatesCorrectStrings() {
        //Arrange
        let markDownItemOne = MockMarkDownItem(lines: ["Test one"], content: "Test one")
        let markDownItemTwo = MockMarkDownItem(lines: ["Test two"], content: "Test two")

        //Act
        let strings = sut.convert([markDownItemOne, markDownItemTwo])

        //Assert
        XCTAssertEqual(strings[0], "Test one")
        XCTAssertEqual(strings[1], "Test two")
    }
}

private class MockMarkDownItem : MarkDownItem {}

private class MockLayoutBlockBuilder : LayoutBlockBuilder<String> {

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return MockMarkDownItem.self
    }

    //MARK: LayoutBuilder

    override func build(markDownItem:MarkDownItem) -> String {
        return markDownItem.lines.first!
    }
}

class MarkDownMockConverterConfiguration : MarkDownConverterConfiguration<String> {

    override init(){
        super.init()
        addMapping(MockMarkDownItem.self, layoutBlockBuilder: MockLayoutBlockBuilder())
    }
}*/
