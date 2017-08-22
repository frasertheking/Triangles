//
//  GameModeViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-22.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class GameModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundGradient(luminosity: .bright)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showLevels") {
            let vc = segue.destination as! LevelsViewController
            vc.selectedIndex = UserDefaultsInteractor.getCurrentLevel()
        } else if (segue.identifier == "showKobon") {
            let vc = segue.destination as! GameViewController
            vc.isKobonMode = true
        }
    }
    
    @IBAction func levelsPressed(sender: UIButton) {
        performSegue(withIdentifier: "showLevels", sender: self)
    }
    
    @IBAction func kobonPressed(sender: UIButton) {
        performSegue(withIdentifier: "showKobon", sender: self)
    }
    
    @IBAction func backPressed(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
