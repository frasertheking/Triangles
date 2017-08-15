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
import Hero

class GameViewController: UIViewController {
    
    // Interface outlets
    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var triangleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var vertexLabel: UILabel!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var triangleContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var vertexContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var triangleCountContainer: UIView!
    @IBOutlet weak var vertexCountContainer: UIView!
    @IBOutlet weak var lineCountContainer: UIView!
    @IBOutlet weak var checkmarkButton: FaveButton!
    
    var levelNumber: Int = 0
    var level: Level = Levels.levels[0]
    var isCreateMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        level = Levels.levels[levelNumber] 
        self.setupBackgroundGradient(landing: false, luminosity: .light)
        self.toggleVertexCounter()
        sketchView.delegate = self
        sketchView.createModeEnabled = isCreateMode
        sketchView.setupLevel(level: level)
        
        triangleLabel.text = isCreateMode ? "0" : "0/\(level.numberOfTrianglesRequired!)"
        lineLabel.text = isCreateMode ? "0" : "0/\(level.numberOfLinesProvided!)"
        vertexLabel.text = isCreateMode ? "0" : "0/\(level.numberOfVerticesRequired!)"
        
        if isCreateMode {
            backButton.setImage(UIImage(named: "back"), for: .normal)
        }
    }
    
    func updateTriangles(triangles: Int) {
        triangleLabel.text = isCreateMode ? "\(triangles)" : "\(triangles)/\(level.numberOfTrianglesRequired!)"
        
        if !isCreateMode && triangles == level.numberOfTrianglesRequired {
            triangleCountContainer.backgroundColor = UIColor.green.withAlphaComponent(0.35)
        } else {
            triangleCountContainer.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        }
        
        if !isCreateMode && sketchView.isLevelComplete(levelNumber: levelNumber, triangleCount: triangles) {
            bounceSketchView()
            self.undoButton.isEnabled = false
            
            // Update userdefaults current level
            UserDefaultsInteractor.updateLevelIfGreaterThanCurrent(level: levelNumber+1)
            
        } else if sketchView.canPerformUndo() {
            undoButton.isEnabled = true
        } else {
            undoButton.isEnabled = false
        }
    }
    
    func updateLines(lines: Int) {
        lineLabel.text = isCreateMode ? "\(lines)" : "\(lines)/\(level.numberOfLinesProvided!)"
        
        if !isCreateMode && lines == level.numberOfLinesProvided {
            lineCountContainer.backgroundColor = UIColor.green.withAlphaComponent(0.35)
        } else {
            lineCountContainer.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        }
    }
    
    func updateVertices(vertices: Int) {
        vertexLabel.text = isCreateMode ? "\(vertices)" : "\(vertices)/\(level.numberOfVerticesRequired!)"
        
        if !isCreateMode && vertices == level.numberOfVerticesRequired {
            vertexCountContainer.backgroundColor = UIColor.green.withAlphaComponent(0.35)
        } else {
            vertexCountContainer.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        }
    }
    
    // Animation functions
    func bounceSketchView() {
        checkmarkButton.isHidden = false
        DispatchQueue.main.async {
            self.checkmarkButton.sendActions(for: .touchUpInside)
        }
        
        UIView.animate(withDuration: 0.25, animations: { self.sketchView.transform = CGAffineTransform(scaleX: 1.075, y: 1.075) }, completion: { (finish: Bool) in UIView.animate(withDuration: 0.25, animations: {
            self.sketchView.transform = CGAffineTransform.identity
        }, completion: { (finished) in
            self.animateNextButtonIn()
            })
        })
    }
    
    func animateNextButtonIn() {
        nextButtonBottomConstraint.constant = 12
        triangleContainerBottomConstraint.constant = 88
        vertexContainerBottomConstraint.constant = 88
        lineContainerBottomConstraint.constant = 88
        
        UIView.animate(withDuration: 0.3, delay: 0.25, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateNextButtonOut() {
        nextButtonBottomConstraint.constant = -80
        triangleContainerBottomConstraint.constant = 12
        vertexContainerBottomConstraint.constant = 12
        lineContainerBottomConstraint.constant = 12
        
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
        level = Levels.levels[levelNumber]
        sketchView.resetStageForLevel(level: level)
        animateNextButtonOut()
        triangleLabel.text = isCreateMode ? "0" : "0/\(level.numberOfTrianglesRequired!)"
        lineLabel.text = isCreateMode ? "0" : "0/\(level.numberOfLinesProvided!)"
        vertexLabel.text = isCreateMode ? "0" : "0/\(level.numberOfVerticesRequired!)"
        checkmarkButton.isHidden = true
        checkmarkButton.sendActions(for: .touchUpInside)
        toggleVertexCounter()
    }
    
    @IBAction func popViewController(sender: UIButton) {
        if isCreateMode {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "landing")
            vc.heroModalAnimationType = .push(direction: .right)
            hero_replaceViewController(with: vc)
        } else {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "levels") as! LevelsViewController
            vc.selectedIndex = levelNumber
            vc.heroModalAnimationType = .zoomOut
            hero_replaceViewController(with: vc)
        }
    }
}
