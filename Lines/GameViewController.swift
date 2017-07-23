//
//  ViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-06-15.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import Pastel

class GameViewController: UIViewController {
    
    // Interface outlets
    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var triangleCountLabel: UILabel!
    @IBOutlet weak var triangleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    var levelNumber = 0
    var level: Level = Levels.levels[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 10.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1.0),
                              UIColor(red: 243/255, green: 129/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0),
                              UIColor(red: 245/255, green: 78/255, blue: 162/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)

        self.nextButton.isHidden = true
        sketchView.delegate = self
        sketchView.setupLevel(level: level)
        triangleLabel.text = "\(level.numberOfTrianglesRequired!)"
        lineLabel.text = "\(level.numberOfLinesProvided!)"
    }
    
    func updateTriangleCount(newCount: Int) {
        self.triangleCountLabel.text = "\(newCount)"
        
        guard let numberOfTrianglesRequired = level.numberOfTrianglesRequired else {
            return
        }
        
        if newCount == numberOfTrianglesRequired && levelNumber < Levels.levels.count-1 {
            self.nextButton.isHidden = false
        } else {
            self.nextButton.isHidden = true
        }
    }
    
    // Action Event Handlers
    @IBAction func clearPressed(sender: UIButton) {
        sketchView.clearAll()
    }
    
    @IBAction func undoPressed(sender: UIButton) {
        sketchView.undo()
    }
    
    @IBAction func nextPressed(sender: UIButton) {
        self.triangleCountLabel.text = "0"
        sketchView.resetStage()
        self.nextButton.isHidden = true
        levelNumber += 1
        level = Levels.levels[levelNumber]
        sketchView.setupLevel(level: level)
        triangleLabel.text = "\(level.numberOfTrianglesRequired!)"
        lineLabel.text = "\(level.numberOfLinesProvided!)"
    }
    
    @IBAction func activateSketchMode(sender: UIButton) {
        sketchView.level = nil
        sketchView.clearAll()
    }
}
