//
//  DetailView.swift
//  CodingTask
//
//  Created by Danny Logiurato on 11.03.24.
//

import UIKit

class ConfirmationView: UIView {
    
    let confirmationLabel = UILabel()
    
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
        confirmationLabel.textAlignment = .center
        confirmationLabel.numberOfLines = 0
        confirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmationLabel)
    }
    
    private func setupConstraints() {
        //Constraints for detailLabel
        NSLayoutConstraint.activate([
            confirmationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            confirmationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            confirmationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    //Update Label with User Input
    func updateWithDetails(_ userDetails: [String: String]) {
        let name = userDetails["name"] ?? ""
        let email = userDetails["email"] ?? ""
        let birthday = userDetails["birthday"] ?? ""
        confirmationLabel.text = "Danke für die Registrierung\n" + "Name: \(name)\nEmail: \(email)\nBirthday: \(birthday)"
    }
}