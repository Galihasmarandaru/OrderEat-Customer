//
//  CancelOrderViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class CancelOrderViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cancelledImageView: UIImageView!
    @IBOutlet weak var orderAgainButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background Orange.png")!)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15
        self.cancelledImageView.image = UIImage(named: "cancelledImage.png")
        self.orderAgainButton.setTitle("Order Again", for: .normal)
        self.orderAgainButton.setTitleColor(.black, for: .normal)
        
        // Do any additional setup after loading the view.
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
