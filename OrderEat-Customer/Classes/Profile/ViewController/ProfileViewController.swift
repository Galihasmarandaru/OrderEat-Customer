//
//  ProfileViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 28/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileUserImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMembershipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() {
        self.view.addBackground()
        profileUserImageView.layer.masksToBounds = true
        profileUserImageView.layer.cornerRadius = profileUserImageView.frame.height / 2
        profileUserImageView.layer.borderWidth = 5
        profileUserImageView.layer.borderColor = UIColor.orangeBorder.cgColor
    }

}
//
//extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//    }
//    
//    
//}
