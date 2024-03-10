//
//  ViewController.swift
//  CodingTask
//
//  Created by Danny Logiurato on 10.03.24.
//

import UIKit

class RegisterController: UIViewController {
    
    var registerView: RegisterView!
    
    override func loadView() {
        registerView = RegisterView()
        view = registerView
    }
}
