//
//  ViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-06-15.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // Interface outlets
    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var triangleCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sketchView.delegate = self
    }
    
    func updateTriangleCount(newCount: Int) {
        self.triangleCountLabel.text = "\(newCount)"
    }
    
    // Action Event Handlers
    @IBAction func clearPressed(sender: UIButton) {
        sketchView.clearAll()
    }
    
    @IBAction func undoPressed(sender: UIButton) {
        sketchView.undo()
    }
}
