//
//  CodingTaskUITests.swift
//  CodingTaskUITests
//
//  Created by Carmelina Logiurato on 10.03.24.
//

import XCTest

class CodingTaskUITests: XCTestCase {

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText("Danny\n")

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("Danny@test.com\n")

        let birthdayTextField = app.textFields["Birthday"]
        birthdayTextField.tap()
        birthdayTextField.typeText("12.02.2002\n")
        
        let registerButton = app.buttons["Register"]
        registerButton.tap()
    }
}
