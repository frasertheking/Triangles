//
//  SuccessViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-23.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import M13Checkbox

class SuccessViewController: UIViewController {

    @IBOutlet weak var completeCheckmark: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundGradient(luminosity: .bright)
        completeCheckmark.toggleCheckState(true)
    }

    @IBAction func popViewController(sender: UIButton) {
        popBack(4)
    }

}
