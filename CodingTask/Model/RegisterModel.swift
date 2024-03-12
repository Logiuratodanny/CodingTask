//
//  RegisterModel.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import Foundation

struct RegistrationModel {
    var name: String
    var email: String
    var birthday: Date
    
    func isValid() -> Bool {
        return validateName() && isValidEmail() && validateBirthday()
    }
    
    func validateName() -> Bool {
        return !name.isEmpty && name.count < 25
    }
    
    func isValidEmail() -> Bool {
        let regex = "^[^@]+@[^@.]+\\.[^@.]+$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", regex)
        return emailPred.evaluate(with: email)
    }
    
    func validateBirthday() -> Bool {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 1900
        components.month = 1
        components.day = 1
        guard let startDate = calendar.date(from: components) else { return false }
        
        components.year = 2022
        components.month = 12
        components.day = 31
        guard let endDate = calendar.date(from: components) else { return false }
        
        return birthday >= startDate && birthday <= endDate
    }
}
