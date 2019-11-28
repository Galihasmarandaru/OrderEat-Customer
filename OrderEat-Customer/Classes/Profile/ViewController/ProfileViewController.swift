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
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var logOutButton: UIButton!
    
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
        
        profileTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.size.width, height: 1))
        
        logOutButton.setTitleColor(.merahTextButton, for: .normal)
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
//        do something here if log out button is clicked
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                let cellPhoneNumber = tableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell", for: indexPath) as! UserDetailTableViewCell
                cellPhoneNumber.leftLabel.text = "Phone Number"
                cellPhoneNumber.rightLabel.text = "+62 812 89866009"

                return cellPhoneNumber
            }
            else {
                let cellEmail = tableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell", for: indexPath) as! UserDetailTableViewCell
                cellEmail.leftLabel.text = "Email"
                cellEmail.rightLabel.text = "galih@icloud.com"

                return cellEmail
            }
        }
        else {
            let cellRate = tableView.dequeueReusableCell(withIdentifier: "RateTableViewCell", for: indexPath) as! RateTableViewCell
            
            return cellRate
        }
    }
    
}
