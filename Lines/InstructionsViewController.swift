//
//  InstructionsViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-14.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundGradient(landing: false, luminosity: .bright)
    }

    @IBAction func popViewController(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
