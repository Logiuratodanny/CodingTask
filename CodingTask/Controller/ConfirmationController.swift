//
//  ViewController.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

class ConfirmationController: UIViewController, RegisterViewDelegate {
    
    var registerView: RegisterView!
    
    override func loadView() {
        registerView = RegisterView()
        registerView.delegate = self
        view = registerView
    }
    
    func registerButtonDidTap() {
        let detailController = DetailController()
        let userDetails = [
            "name": registerView.nameTextField.text ?? "",
            "email": registerView.emailTextField.text ?? "",
            "birthday": registerView.birthdayTextField.text ?? ""
        ]
        detailController.userdata = userDetails
        navigationController?.pushViewController(detailController, animated: true)
    }
}
