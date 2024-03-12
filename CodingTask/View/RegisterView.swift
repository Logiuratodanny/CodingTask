//
//  RegisterView.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonDidTap()
    func presentAlert(withTitle title: String, message: String)
}

class RegisterView: UIView {
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let birthdayTextField = UITextField()
    let registerButton = UIButton()
    let titleLabel = UILabel()
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
        
        //Setup title Label
        titleLabel.text = "Register"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        //Remove Autolayout
        [nameTextField, emailTextField, birthdayTextField, registerButton, titleLabel].forEach {
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
        guard let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let birthdayString = birthdayTextField.text, !birthdayString.isEmpty else {
            delegate?.presentAlert(withTitle: "Error", message: "Please fill all fields.")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let birthdayDate = dateFormatter.date(from: birthdayString) else {
            delegate?.presentAlert(withTitle: "Error", message: "Invalid Birthday format.")
            return
        }

        let registrationModel = RegistrationModel(name: name, email: email, birthday: birthdayDate)
        if registrationModel.isValid() {
            delegate?.registerButtonDidTap()
        } else {
            delegate?.presentAlert(withTitle: "Error", message: "Invalid registration details")
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
        
        // Constraints for titleLabel
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -40), // Adjust the spacing as needed
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
}
