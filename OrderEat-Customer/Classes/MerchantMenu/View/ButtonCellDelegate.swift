//
//  ButtonCellDelegate.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 07/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate: class {
    func didPressButtonAdd(_ tag: Int)
    func didPressButtonCart(_ tag: Int)
}
