//
//  RegisterView.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonDidTap()
}

class RegisterView: UIView {
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let birthdayTextField = UITextField()
    let registerButton = UIButton()
    weak var delegate: RegisterViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        //Remove Autolayout
        [nameTextField, emailTextField, birthdayTextField, registerButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }

        // Add name to textfield
        nameTextField.placeholder = "Name"
        emailTextField.placeholder = "Email"
        birthdayTextField.placeholder = "Birthday"
        
        // Customize the textfields
        [nameTextField, emailTextField, birthdayTextField].forEach {
            $0.borderStyle = .roundedRect
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 7.0
        }

        // Customize the register button
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemGreen
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }

    // Register Button
    @objc private func registerButtonTapped() {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let birthdayString = birthdayTextField.text else {
            print("Missing information")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let birthdayDate = dateFormatter.date(from: birthdayString) else {
            print("Invalid birthday format")
            return
        }
        
        let registrationModel = RegistrationModel(name: name, email: email, birthday: birthdayDate)
        if registrationModel.isValid() {
            delegate?.registerButtonDidTap()
        } else {
            print("Invalid registration details")
        }
    }
    
    private func setupConstraints() {
        // Constraints for nameTextField
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60),
            nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
        
        // Constraints for emailTextField
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor)
        ])
        
        // Constraints for birthdayTextField
        NSLayoutConstraint.activate([
            birthdayTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            birthdayTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            birthdayTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor)
        ])
        
        // Constraints for RegisterButton
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
