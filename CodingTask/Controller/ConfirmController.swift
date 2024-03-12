//
//  DetailController.swift
//  CodingTask
//
//  Created by Danny Logiurato on 11.03.24.
//

import UIKit

class ConfirmController: UIViewController {
    
    var confermationView: ConfirmationView!
    var userdata: [String: String]?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        confermationView = ConfirmationView()
        view = confermationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let detailData = userdata {
            confermationView.updateWithDetails(detailData)
        }
    }
}
