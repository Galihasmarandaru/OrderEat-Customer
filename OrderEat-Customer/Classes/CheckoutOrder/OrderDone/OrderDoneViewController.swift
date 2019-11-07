//
//  OrderDoneViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 07/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderDoneViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        // Do any additional setup after loading the view.
    }
    
    func config() {
        self.view.addBackground()
        headerView.layer.masksToBounds = true
        headerView.layer.cornerRadius = 15
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
