//
//  CodingTaskTests.swift
//  CodingTaskTests
//
//  Created by Danny Logiurato on 10.03.24.
//

import XCTest
@testable import CodingTask

class RegistrationModelTests: XCTestCase {

    private func testValidName() {
        let registration = RegistrationModel(name: "Danny", email: "Danny@test.com", birthday: Date())
        XCTAssertTrue(registration.validateName(), "Valid name failed validation.")
    }
    
    private func testEmptyName() {
        let registration = RegistrationModel(name: "", email: "Danny@test.com", birthday: Date())
        XCTAssertFalse(registration.validateName(), "Empty name passed validation.")
    }
    
    private func testNameToLong() {
        let registration = RegistrationModel(name: "Janekdjskjdkjskdjklsdklsakdkjdkljkd", email: "Danny@test.com", birthday: Date())
        XCTAssertFalse(registration.validateName(), "Name too long passed validation.")
    }
    
    func testBirthdayValid() {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.year = 2000
        dateComponent.month = 1
        dateComponent.day = 1
        let validBirthday = calendar.date(from: dateComponent)!

        let registration = RegistrationModel(name: "Danny", email: "Danny@test.com", birthday: validBirthday)
        XCTAssertTrue(registration.validateBirthday(), "Valid registration failed")
    }
    
    func testBirthdayinValid() {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.year = 2030
        dateComponent.month = 1
        dateComponent.day = 1
        let invalidBirthday = calendar.date(from: dateComponent)!

        // All valid
        let registration = RegistrationModel(name: "Danny", email: "Danny@test.com", birthday: invalidBirthday)
        XCTAssertFalse(registration.validateBirthday(), "Invalid Birthday")
    }
    
    func testValidEmail() {
        let registration = RegistrationModel(name: "Danny", email: "Danny@test.com", birthday: Date())
        XCTAssertTrue(registration.isValidEmail(), "Valid email failed validation.")
    }
    
    func testInValidEmail() {
        let registration = RegistrationModel(name: "Danny", email: "Danny@.com", birthday: Date())
        XCTAssertFalse(registration.isValidEmail(), "Valid email failed validation.")
    }
}
