//
//  InstructionsViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-14.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import M13Checkbox

class InstructionsViewController: UIViewController {

    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var triangleContainerView: UIView!
    @IBOutlet weak var lineContainerView: UIView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepDescriptionLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var finalNoteLabel: UILabel!
    @IBOutlet weak var completeCheckmark: M13Checkbox!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkmarkButton: M13Checkbox!

    var index = 0
    let stepDescriptions = ["Drag your finger below to draw a line across the screen",
                            "Draw two lines that cross to create an intersection",
                            "Intersect three lines below to create a triangle",
                            "Construct 2 triangles by adding 2 lines to the shape below"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundGradient(luminosity: .bright)

        sketchView.helpDelegate = self
        sketchView.createModeEnabled = true
        sketchView.setupLevel(level: Levels.levels[0])
        undoButton.isEnabled = false
        completeLabel.alpha = 0
        finalNoteLabel.alpha = 0
        triangleContainerView.alpha = 0
        lineContainerView.alpha = 0
    }

    @IBAction func popViewController(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func updateTriangles(triangles: Int) {
        if index == 2 && triangles > 0 {
            showNext()
        }
        
        if index == 3 && triangles == 2 {
            showNext()
        }
    }
    
    func updateLines(lines: Int) {
        if lines > 0 {
            undoButton.isEnabled = true
        } else {
            undoButton.isEnabled = false
        }
        
        if index == 0 && lines > 0 {
            showNext()
        }
    }
    
    func updateVertices(vertices: Int) {
        if index == 1 && vertices > 0 {
            showNext()
        }
    }
    
    func showNext() {
        nextButtonBottomConstraint.constant = 16
        AudioInteractor.playSuccess()
        
        if checkmarkButton.checkState == .unchecked {
            checkmarkButton.toggleCheckState(true)
        }
        
        if index == 3 {
            nextButton.setTitle("Finish", for: .normal)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            if self.index == 3 {
                self.triangleContainerView.alpha = 0
                self.lineContainerView.alpha = 0
            }
        }, completion: nil)
    }
    
    func hideNext() {
        nextButtonBottomConstraint.constant = -70
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateLabelTextChange() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.stepLabel.alpha = 0
            self.stepDescriptionLabel.alpha = 0
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.stepLabel.text = "Step \(self.index+1)"
                self.stepDescriptionLabel.text = self.stepDescriptions[self.index]
                self.stepLabel.alpha = 1
                self.stepDescriptionLabel.alpha = 1
                if self.index == 3 {
                    self.sketchView.createModeEnabled = false
                    self.sketchView.setupLevel(level: Levels.tutorialLevel)
                    self.triangleContainerView.alpha = 1
                    self.lineContainerView.alpha = 1
                }
            }, completion: nil)
        })
    }
    
    func hideAllAndShowComplete() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.stepLabel.alpha = 0
            self.stepDescriptionLabel.alpha = 0
            self.sketchView.alpha = 0
            self.undoButton.alpha = 0
            self.separatorView.alpha = 0
            self.triangleContainerView.alpha = 0
            self.lineContainerView.alpha = 0
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.completeLabel.alpha = 1
                self.finalNoteLabel.alpha = 1
                self.completeCheckmark.toggleCheckState(true)
            }, completion: nil)
        })
    }
    
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
        index = index + 1
        hideNext()
        if checkmarkButton.checkState == .checked {
            checkmarkButton.toggleCheckState(true)
        }
        sketchView.clearAll()
        undoButton.isEnabled = false

        if index == 4 {
            hideAllAndShowComplete()
        } else {
            animateLabelTextChange()
        }
    }
}
