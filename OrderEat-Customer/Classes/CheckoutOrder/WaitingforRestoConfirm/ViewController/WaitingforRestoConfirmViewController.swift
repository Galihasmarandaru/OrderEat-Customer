//
//  WaitingforRestoConfirmViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class WaitingforRestoConfirmViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var waitingImageView: UIImageView!
    @IBOutlet weak var cancelOrderButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
        // Do any additional setup after loading the view.
    }
    
    func config() {
        self.view.addBackground()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15
        self.waitingImageView.image = UIImage(named: "waitingImage.png")
        self.cancelOrderButton.setTitle("Cancel Order", for: .normal)
        self.cancelOrderButton.setTitleColor(.merahTextButton, for: .normal)
    }
    
    @IBAction func cancelOrderButtonPressed(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
