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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var triangleCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var levelNumber = 0
    var level: Level = Levels.levels[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.isHidden = true
        sketchView.delegate = self
        sketchView.setupLevel(level: level)
        descriptionLabel.text = "Make \(level.numberOfTrianglesRequired!) triangles with \(level.numberOfLinesProvided!) line(s)"
    }
    
    func updateTriangleCount(newCount: Int) {
        self.triangleCountLabel.text = "\(newCount)"
        
        guard let numberOfTrianglesRequired = level.numberOfTrianglesRequired else {
            return
        }
        
        if newCount >= numberOfTrianglesRequired && levelNumber < Levels.levels.count-1 {
            self.nextButton.isHidden = false
        }
    }
    
    func calculateMaxTriangles() {
        sketchView.dontDrawTriangles = true
        for i in stride(from: 0, to: UIScreen.main.bounds.size.width, by: 30) {
            for j in stride(from: 0, to: UIScreen.main.bounds.size.height / 2, by: 30) {
                sketchView.drawLine(fromPoint: CGPoint(x: i, y: j), toPoint: CGPoint(x: UIScreen.main.bounds.size.width - i, y: UIScreen.main.bounds.size.height - j), doneDrawingLine: true)
                /*for k in stride(from: 0, to: UIScreen.main.bounds.size.width, by: 30) {
                 for l in stride(from: 0, to: UIScreen.main.bounds.size.height / 2, by: 30) {
                 sketchView.drawLine(fromPoint: CGPoint(x: k, y: l), toPoint: CGPoint(x: UIScreen.main.bounds.size.width - k, y: UIScreen.main.bounds.size.height - l), doneDrawingLine: true)
                 sketchView.undo()
                 }
                 }*/
                sketchView.clearAll()
            }
        }
        sketchView.dontDrawTriangles = false
        
        for line in sketchView.maxLines {
            sketchView.drawLine(fromPoint: line.start!, toPoint: line.end!, doneDrawingLine: true)
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
        sketchView.resetStage()
        self.nextButton.isHidden = true
        levelNumber += 1
        level = Levels.levels[levelNumber]
        sketchView.setupLevel(level: level)
        descriptionLabel.text = "Make \(level.numberOfTrianglesRequired!) triangles with \(level.numberOfLinesProvided!) line(s)"
    }
    
    @IBAction func activateSketchMode(sender: UIButton) {
        sketchView.level = nil
        sketchView.clearAll()
    }
}
