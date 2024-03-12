//
//  RegisterView.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonDidTap(withName name: String, email: String, birthday: String)
    func presentAlert(withTitle title: String, message: String)
}

class RegisterView: UIView {
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let birthdayTextField = UITextField()
    let registerButton = UIButton(type: .system)
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
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .systemBackground
        addSubviews()
        configureTitleLabel()
        configureTextFields()
        configureRegisterButton()
        initializeTextFieldObservers()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(birthdayTextField)
        addSubview(registerButton)
    }
    
    // MARK: - Configuration of Buttons and Labels
    private func configureTitleLabel() {
        titleLabel.text = "Register"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextFields() {
        let textFields = [nameTextField, emailTextField, birthdayTextField]
        textFields.forEach { textField in
            textField.borderStyle = .roundedRect
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 7.0
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Add name to textfield
        nameTextField.placeholder = "Name"
        emailTextField.placeholder = "Email"
        birthdayTextField.placeholder = "Birthday"
    }
    
    private func configureRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .lightGray
        registerButton.isEnabled = false
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Validating that Textfield is not empty
    @objc private func registerButtonTapped() {
        if let name = nameTextField.text, !name.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let birthday = birthdayTextField.text, !birthday.isEmpty {
            delegate?.registerButtonDidTap(withName: name, email: email, birthday: birthday)
        }
    }
    
    // MARK: - Disable/Enable Button
    private func initializeTextFieldObservers() {
        [nameTextField, emailTextField, birthdayTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @objc private func textFieldDidChange() {
        let areAllFieldsFilled = !(nameTextField.text?.isEmpty ?? true) &&
            !(emailTextField.text?.isEmpty ?? true) &&
            !(birthdayTextField.text?.isEmpty ?? true)
        registerButton.isEnabled = areAllFieldsFilled
        registerButton.backgroundColor = areAllFieldsFilled ? .systemGreen : .lightGray
    }
    
    // MARK: - Constraints
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
            titleLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -40),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
}
