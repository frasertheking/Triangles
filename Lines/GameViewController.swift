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
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var triangleCountLabel: UILabel!
    @IBOutlet weak var triangleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var triangleContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var vertexContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var vertexCountContainer: UIView!
    
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

        vertexCountContainer.isHidden = true
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
            bounceSketchView()
            self.undoButton.isEnabled = false
        } else {
            self.undoButton.isEnabled = true
        }
    }
    
    func bounceSketchView() {
        UIView.animate(withDuration: 0.25, animations: { self.sketchView.transform = CGAffineTransform(scaleX: 1.075, y: 1.075) }, completion: { (finish: Bool) in UIView.animate(withDuration: 0.25, animations: {
            self.sketchView.transform = CGAffineTransform.identity
        }, completion: { (finished) in
            self.animateNextButtonIn()
            })
        })
    }
    
    func animateNextButtonIn() {
        nextButtonBottomConstraint.constant = 20
        triangleContainerBottomConstraint.constant = 100
        vertexContainerBottomConstraint.constant = 100
        lineContainerBottomConstraint.constant = 100
        
        UIView.animate(withDuration: 0.3, delay: 0.25, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateNextButtonOut() {
        nextButtonBottomConstraint.constant = -80
        triangleContainerBottomConstraint.constant = 20
        vertexContainerBottomConstraint.constant = 20
        lineContainerBottomConstraint.constant = 20
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // Action Event Handlers
    
    @IBAction func undoPressed(sender: UIButton) {
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: -Double(CGFloat.pi * 2))
        fullRotation.duration = 0.5
        fullRotation.repeatCount = 1
        undoButton.layer.add(fullRotation, forKey: "360")
        
        sketchView.undo()
    }
    
    @IBAction func nextPressed(sender: UIButton) {
        levelNumber += 1
        level = Levels.levels[levelNumber]
        sketchView.resetStageForLevel(level: level)
        animateNextButtonOut()
        triangleLabel.text = "\(level.numberOfTrianglesRequired!)"
        lineLabel.text = "\(level.numberOfLinesProvided!)"
    }
    
    @IBAction func activateSketchMode(sender: UIButton) {
        sketchView.level = nil
    }
}
