//
//  ViewController.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

class RegisterController: UIViewController, RegisterViewDelegate {
    
    var registerView: RegisterView!
    
    override func loadView() {
        registerView = RegisterView()
        registerView.delegate = self
        view = registerView
    }
    
    func registerButtonDidTap() {
        let detailController = ConfirmController()
        let userDetails = [
            "name": registerView.nameTextField.text ?? "",
            "email": registerView.emailTextField.text ?? "",
            "birthday": registerView.birthdayTextField.text ?? ""
        ]
        detailController.userdata = userDetails
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func presentAlert(withTitle title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            present(alertController, animated: true)
        }
}
