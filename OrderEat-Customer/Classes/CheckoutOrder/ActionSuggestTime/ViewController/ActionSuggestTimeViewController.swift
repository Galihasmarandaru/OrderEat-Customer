//
//  ActionSuggestTimeViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 09/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ActionSuggestTimeViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() {
        self.view.addBackground()
        acceptButton.backgroundColor = .orangeButton
        acceptButton.layer.cornerRadius = 20
        acceptButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15
    }

    @IBAction func acceptButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        
    }
    
}
