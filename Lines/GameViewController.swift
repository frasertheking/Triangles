//
//  ViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-06-15.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import Pastel
import Hero
import M13Checkbox

class GameViewController: UIViewController {
    
    // Interface outlets
    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
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
    @IBOutlet weak var checkmarkButton: M13Checkbox!
    
    var delegate: LevelsViewController?
    var levelNumber: Int = 0
    var level: Level = Levels.levels[0]
    var isCreateMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        level = Levels.levels[levelNumber] 
        self.setupBackgroundGradient(landing: false, luminosity: .bright)
        self.toggleVertexCounter()
        sketchView.delegate = self
        sketchView.createModeEnabled = isCreateMode
        sketchView.setupLevel(level: level)
        
        if isCreateMode {
            backButton.setImage(UIImage(named: "back"), for: .normal)
            undoButton.isEnabled = false
            shareButton.isHidden = false
            triangleLabel.text = isCreateMode ? "0" : "0/\(level.numberOfTrianglesRequired!)"
            lineLabel.text = isCreateMode ? "0" : "0/\(level.numberOfLinesProvided!)"
            vertexLabel.text = isCreateMode ? "0" : "0/\(level.numberOfVerticesRequired!)"
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
            self.undoButton.setImage(UIImage(named: "share"), for: .normal)
            self.undoButton.removeTarget(nil, action: nil, for: .allEvents)
            self.undoButton.addTarget(self, action: #selector(share(sender:)), for: .touchUpInside)
            undoButton.isEnabled = true

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
        self.checkmarkButton.toggleCheckState(true)
        
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
        delegate?.selectedIndex = levelNumber
        level = Levels.levels[levelNumber]
        sketchView.resetStageForLevel(level: level)
        animateNextButtonOut()
        triangleLabel.text = isCreateMode ? "0" : "0/\(level.numberOfTrianglesRequired!)"
        lineLabel.text = isCreateMode ? "0" : "0/\(level.numberOfLinesProvided!)"
        vertexLabel.text = isCreateMode ? "0" : "0/\(level.numberOfVerticesRequired!)"
        checkmarkButton.toggleCheckState(true)
        toggleVertexCounter()
        self.undoButton.setImage(UIImage(named: "undo"), for: .normal)
        self.undoButton.removeTarget(nil, action: nil, for: .allEvents)
        self.undoButton.addTarget(self, action: #selector(undoPressed(sender:)), for: .touchUpInside)
    }
    
    @IBAction func share(sender: UIButton) {
        let image = captureScreen()
        let text = "Check out this puzzle in Kobon. Think you can solve this? Get it on the App store today!"
        var activityItems: [Any]

        if let image = image {
            activityItems = [image, text]
        } else {
            activityItems = [text]
        }
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func popViewController(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
