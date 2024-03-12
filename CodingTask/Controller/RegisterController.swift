//
//  ViewController.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

class RegisterController: UIViewController, RegisterViewDelegate {
    
    var registerView: RegisterView!
    
    // MARK: - Lifecycle
    override func loadView() {
        registerView = RegisterView()
        registerView.delegate = self
        view = registerView
    }
    
    // MARK: - Pass data to ConfirmView
    func registerButtonDidTap(withName name: String, email: String, birthday: String) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy"
          guard let birthdayDate = dateFormatter.date(from: birthday) else {
              presentAlert(withTitle: "Error", message: "Invalid Birthday format.")
              return
          }
          
          let registrationModel = RegistrationModel(name: name, email: email, birthday: birthdayDate)
        
          if registrationModel.isValid() {
            let confirmController = ConfirmController()
            let userDetails = ["name": name, "email": email, "birthday": birthday]
            confirmController.userdata = userDetails
            navigationController?.pushViewController(confirmController, animated: true)
          } else {
              presentAlert(withTitle: "Error", message: "Invalid registration details.")
          }
      }
    
    // MARK: - Invalid Fields Alert
    func presentAlert(withTitle title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            present(alertController, animated: true)
        }
}
