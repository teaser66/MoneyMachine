//
//  Money_MachineUITests.swift
//  Money MachineUITests
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import XCTest

class Money_MachineUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanNotSaveEmptyForm() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // given
        let app = XCUIApplication()
        app.buttons["receipt"].tap()
        app.navigationBars["Saving Form"].buttons["Save"].tap()
        app.alerts["Save Details?"].buttons["Save"].tap()
        
        // when
        let theErrorAlert = app.alerts["Invalid Entry"].staticTexts["Invalid Entry"]
        
        // then
        XCTAssertTrue(theErrorAlert.exists)
        
    }
    
    func testCanNotSearchEmptyForm() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // given
        let app = XCUIApplication()
        app.buttons["search icon"].tap()
        app.navigationBars["Search Form"].buttons["Search"].tap()
        
        
        // when
        let theErrorAlert = app.alerts["Nothing to search"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .other).element
        
        // then
        XCTAssertTrue(theErrorAlert.exists)
        
    }
    
    

}
