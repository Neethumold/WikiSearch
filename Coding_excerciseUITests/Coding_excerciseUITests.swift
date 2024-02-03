//
//  Coding_excerciseUITests.swift
//  Coding_excerciseUITests
//
//  Created by Neethu on 02/02/2024.
//

import XCTest

final class Coding_excerciseUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testToValidateTitleCountWithValidInput() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchWikipediaTextField = app.textFields["Search Wikipedia"]
        searchWikipediaTextField.tap()
        searchWikipediaTextField.typeText("Swift")
        app.buttons["Search"].tap()
        sleep(3)
        let countLabel = app.staticTexts["The number of times that the string \"Swift\" appears in the article is 23"]
        XCTAssertTrue(countLabel.exists)
    }
    
    func testToValidateTitleCountWithInvalidInput() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchWikipediaTextField = app.textFields["Search Wikipedia"]
        searchWikipediaTextField.tap()
        searchWikipediaTextField.typeText("qwerty*")
        app.buttons["Search"].tap()
        sleep(3)
        let countLabel = app.staticTexts["The data couldn’t be read because it is missing."]
        XCTAssertTrue(countLabel.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
