//
//  ConwaysLifeUITests.swift
//  ConwaysLifeUITests
//
//  Created by Aleksey Nikolaenko on 13.07.2022.
//

import XCTest

class ConwaysLifeUITests: XCTestCase {

    static let app = XCUIApplication()

    override class func setUp() {
        app.launch()
    }
    
    func testUIComponentsVisibility() throws {
        let button = XCUIApplication().buttons["Next generation"].firstMatch
        XCTAssertEqual(button.label, "Next generation")

        let labelElement = XCUIApplication().staticTexts["ConwaysGameOfLife"]
        XCTAssertEqual(labelElement.label, "Conway’s Game of Life")
    }
    
    func testNewGenerationTap() throws {
        let button = XCUIApplication().buttons["Next generation"].firstMatch

        let cells = XCUIApplication().images
        XCTAssertEqual(cells.count, 101, "Incorrect images grid")
        XCTAssertEqual(cells.element(boundBy: 1).label, "alive")
        XCTAssertEqual(cells.element(boundBy: 2).label, "alive")
        XCTAssertEqual(cells.element(boundBy: 10).label, "dead")

        button.tap()

        XCTAssertEqual(cells.count, 101, "Incorrect images grid")
        XCTAssertEqual(cells.element(boundBy: 1).label, "alive")
        XCTAssertEqual(cells.element(boundBy: 2).label, "dead")
        XCTAssertEqual(cells.element(boundBy: 10).label, "dead")
    }
}
