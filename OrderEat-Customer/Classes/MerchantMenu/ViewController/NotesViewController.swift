//
//  SigninViewController.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 08/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var barNotes: UIView!
    
    @IBOutlet weak var textFieldNotes: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        textFieldNotes.becomeFirstResponder()
    }
}
