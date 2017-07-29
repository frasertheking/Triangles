//
//  ViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-06-15.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import Pastel
import FaveButton

class GameViewController: UIViewController {
    
    // Interface outlets
    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var triangleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var vertexLabel: UILabel!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var triangleContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var vertexContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var vertexCountContainer: UIView!
    @IBOutlet weak var checkmarkButton: FaveButton!
    
    var levelNumber = 0
    var level: Level = Levels.levels[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackgroundGradient()
        self.toggleVertexCounter()
        sketchView.delegate = self
        sketchView.setupLevel(level: level)
        triangleLabel.text = "0/\(level.numberOfTrianglesRequired!)"
        lineLabel.text = "0/\(level.numberOfLinesProvided!)"
        vertexLabel.text = "0/\(level.numberOfVerticesRequired!)"
    }
    
    func updateTriangles(triangles: Int) {
        triangleLabel.text = "\(triangles)/\(level.numberOfTrianglesRequired!)"
        
        if sketchView.isLevelComplete(levelNumber: levelNumber, triangleCount: triangles) {
            bounceSketchView()
            self.undoButton.isEnabled = false
        } else if sketchView.canPerformUndo() {
            undoButton.isEnabled = true
        } else {
            undoButton.isEnabled = false
        }
    }
    
    func updateLines(lines: Int) {
        lineLabel.text = "\(lines)/\(level.numberOfLinesProvided!)"
    }
    
    func updateVertices(vertices: Int) {
        vertexLabel.text = "\(vertices)/\(level.numberOfVerticesRequired!)"
    }
    
    // Animation functions
    func bounceSketchView() {
        checkmarkButton.isHidden = false
        levelLabel.isHidden = true
        checkmarkButton.sendActions(for: .touchUpInside)

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
    
    func toggleVertexCounter() {
        vertexCountContainer.isHidden = level.numberOfVerticesRequired != -1 ? false : true
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
        levelLabel.text = "\(levelNumber+1)"
        level = Levels.levels[levelNumber]
        sketchView.resetStageForLevel(level: level)
        animateNextButtonOut()
        triangleLabel.text = "0/\(level.numberOfTrianglesRequired!)"
        lineLabel.text = "0/\(level.numberOfLinesProvided!)"
        vertexLabel.text = "0/\(level.numberOfVerticesRequired!)"
        checkmarkButton.isHidden = true
        levelLabel.isHidden = false
        checkmarkButton.sendActions(for: .touchUpInside)
        toggleVertexCounter()
    }
}
