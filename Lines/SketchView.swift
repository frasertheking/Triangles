//
//  SketchView.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import RandomColorSwift

class SketchView: UIView {
    
    // Interface outlets
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var vertexView: UIView!
    @IBOutlet weak var lineView: UIView!
    var tapGestureRecognizer: UITapGestureRecognizer!
    var delegate: GameViewController?
    
    // DEV MODE
    var devModeEnabled = false
    
    // Constants
    fileprivate let kVertexRadius: CGFloat = 10.0
    fileprivate let kMinimumTriangleSize: CGFloat = 100.0
    fileprivate let kAnimationDuration: TimeInterval = 0.2
    fileprivate let kSwollenVertexScaleFactor: CGFloat = 1.25
    fileprivate let kLineWidth: CGFloat = 4.0
    fileprivate let kTriangleStrokeBufferWidth: CGFloat = 4.0
    var kLineColor: UIColor = UIColor.black
    
    // Global vars
    fileprivate var firstPoint: CGPoint?
    fileprivate var secondPoint: CGPoint?
    fileprivate var lineArr: [Line] = [Line]()
    fileprivate var triangleArray: [Triangle] = [Triangle]()
    fileprivate var intersectionArray: [CGPoint] = [CGPoint]()
    fileprivate var lineCount: Int = 0
    fileprivate var lineStart: CGPoint?
    fileprivate var undoFrameRefresh: Bool = false
    fileprivate var startingLineCount = 0
    
    // Public vars
    var numberOfTriangles: Int {
        get {
            return self.numberOfTriangles
        }
        set {
            self.delegate?.updateTriangles(triangles: newValue)
        }
    }
    var numberOfLines: Int {
        get {
            return self.numberOfLines
        }
        set {
            self.delegate?.updateLines(lines: newValue)
        }
    }
    var numberOfVertices: Int {
        get {
            return self.numberOfVertices
        }
        set {
            self.delegate?.updateVertices(vertices: newValue)
        }
    }
    var level: Level?
    var dontDrawTriangles: Bool = false
    var levelLoaded: Bool = false

    // Max generation vars
    var maxTriangles = 0
    var maxLines: [Line] = [Line]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        addSubview(view)
        
        // Setup gesture recognizer for pan gestures
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        gestureRecognizer.minimumPressDuration = 0.0
        view.addGestureRecognizer(gestureRecognizer)
        
        // Add parallax features to views
        self.addParallaxToView(vw: triangleView)
        self.addParallaxToView(vw: lineView)
        self.addParallaxToView(vw: vertexView)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    // Level setup 
    func setupLevel(level: Level) {
        self.level = level
        if !self.devModeEnabled {
            self.generateLevel()
            levelLoaded = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear, animations: {
            self.lineView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.75, options: .curveLinear, animations: {
            self.triangleView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveLinear, animations: {
            self.vertexView.alpha = 1
        }, completion: nil)
    }
    
    func generateLevel() {
        
        guard let level = self.level else {
            return
        }
        
        guard let lines = level.lines else {
            return
        }
        
        levelLoaded = false
        startingLineCount = 0
        lineCount = startingLineCount
        for line in lines {
            startingLineCount += 1
            drawLine(fromPoint: line.start!, toPoint: line.end!, doneDrawingLine: true)
        }
        lineCount = startingLineCount
    }
    
    func isLevelComplete(levelNumber: Int, triangleCount: Int) -> Bool {
        
        guard let numberOfTrianglesRequired = level?.numberOfTrianglesRequired else {
            return false
        }
        
        guard let numberOfVerticesRequired = level?.numberOfVerticesRequired else {
            return false
        }
        
        guard let numberOfLinesProvided = level?.numberOfLinesProvided else {
            return false
        }
        
        if numberOfVerticesRequired != -1 && intersectionArray.count != numberOfVerticesRequired {
            return false
        }
        
        if triangleCount == numberOfTrianglesRequired &&
            (lineCount - startingLineCount) == numberOfLinesProvided &&
            levelLoaded &&
            levelNumber < Levels.levels.count-1 {
            
            return true
        }
        
        return false
    }
    
    // Action Event Handlers
    func resetStageForLevel(level: Level) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: { 
            self.vertexView.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
            self.triangleView.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear, animations: {
            self.lineView.alpha = 0
        }) { (finished) in
            self.vertexView.layer.sublayers = nil
            self.lineView.layer.sublayers = nil
            self.triangleView.layer.sublayers = nil
            self.lineArr.removeAll()
            self.intersectionArray.removeAll()
            self.triangleArray.removeAll()
            self.lineCount = 0
            self.startingLineCount = 0
            self.setupLevel(level: level)
        }
    }
    
    func clearAll() {
        self.vertexView.layer.sublayers = nil
        self.lineView.layer.sublayers = nil

        lineArr.removeAll()
        intersectionArray.removeAll()
        if !devModeEnabled {
            generateLevel()
        }
        findIntersections()
    }
    
    func undo() {
        if canPerformUndo() {
            lineCount -= 1
            numberOfLines = lineCount - startingLineCount
            
            removeLayerFromView(by: lineCount, view: lineView)
            lineArr.removeLast()
            intersectionArray.removeAll()
            self.vertexView.layer.sublayers = nil
            undoFrameRefresh = true
            findIntersections()
        }
    }
    
    func canPerformUndo() -> Bool {
        return lineCount > startingLineCount
    }
    
    func handleGesture(gesture: UILongPressGestureRecognizer) {

        guard let level = self.level else {
            return
        }
        
        guard let numberOfLinesProvided = level.numberOfLinesProvided else {
            return
        }
        
        if (lineCount < startingLineCount + numberOfLinesProvided) || devModeEnabled {
            if gesture.state == .began {
                lineStart = gesture.location(in: self)
            }
            
            if gesture.state == .ended {
                if let lineStart = lineStart {
                    if lineStart.distance(gesture.location(in: self)) > 10 {
                        drawLine(fromPoint: lineStart, toPoint: gesture.location(in: self), doneDrawingLine: true)
                        print("Line(id: -1, start: CGPoint(x: \(lineStart.x), y: \(lineStart.y)), end: CGPoint(x: \(gesture.location(in: self).x), y: \(gesture.location(in: self).y))),")
                    }
                }
            }
            
            if gesture.state == .changed {
                if let lineStart = lineStart {
                    if lineStart.distance(gesture.location(in: self)) > 10 {
                        drawLine(fromPoint: lineStart, toPoint: gesture.location(in: self), doneDrawingLine: false)
                    }
                }
            }
        }
    }
    
    // Line logic for creating minimal triangles (this is the fun mathy stuff)
    func findIntersections() {
        triangleArray = [Triangle]()
        
        for i in 0 ..< lineArr.count {
            var intersectionCount: Int = 0
            var intersectionArr: [Line] = [Line]()
            
            for j in i+1 ..< lineArr.count {
                if let lineStart = lineArr[j].start, let lineEnd = lineArr[j].end {
                    if lineArr[i].intersectsWithLine(line2: (a: lineStart, b: lineEnd)) {
                        intersectionCount += 1
                        intersectionArr.append(lineArr[j])
                        
                        // Check to see if intersection with already present vertex radius
                        var intersectionPoint = lineArr[i].getIntersectionPointForLine(line2: (a: lineStart, b: lineEnd))
                        var drawVertex = true

                        for point in intersectionArray {
                            if (pow((intersectionPoint.x - point.x), 2) + pow((intersectionPoint.y - point.y), 2) < pow(kVertexRadius, 2)) && point != intersectionPoint {
                                intersectionPoint = point
                            }
                            
                            if (pow((intersectionPoint.x - point.x), 2) + pow((intersectionPoint.y - point.y), 2) < 2*pow(kVertexRadius, 2)) {
                                drawVertex = false
                            }
                        }
                        
                        if intersectionArray.index(of: intersectionPoint) == nil && drawVertex {
                            intersectionArray.append(intersectionPoint)
                            numberOfVertices = intersectionArray.count
                            drawVertices(x: intersectionPoint.x - kVertexRadius, y: intersectionPoint.y - kVertexRadius)
                        }
                    }
                    
                    if let triangles: [Triangle] = Triangle.getTriangleFromLines(lines: intersectionArr, currentLine: lineArr[i], intersectionArray: self.intersectionArray, currentTriangles: self.triangleArray) {
                        for triangle in triangles {
                            triangleArray.append(triangle)
                        }
                    }
                }
            }
        }
        
        // Remove maximum triangles from the triangle array
        let minArray = Triangle.markMaximumTrianglesInArray(triangles: triangleArray, lines: lineArr)
        drawTriangles(array: minArray)
    }
    
    // Drawing functions
    func drawLine(fromPoint start: CGPoint, toPoint end:CGPoint, doneDrawingLine: Bool) {
        let roundedStart = CGPoint(x: round(start.x), y: round(start.y))
        let roundedEnd = CGPoint(x: round(end.x), y: round(end.y))
        
        removeLayerFromView(by: lineCount, view: lineView)
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: roundedStart)
        linePath.addLine(to: roundedEnd)
        line.path = linePath.cgPath
        line.strokeColor = kLineColor.cgColor
        line.lineWidth = kLineWidth
        line.lineJoin = kCALineJoinRound
        line.lineCap = "round"
        line.name = "\(lineCount)"
        self.lineView.layer.addSublayer(line)
        
        if doneDrawingLine {
            lineArr.append(Line(id: lineCount, start: roundedStart, end: roundedEnd))
            lineCount += 1
            numberOfLines = lineCount - startingLineCount
            undoFrameRefresh = false
            findIntersections()
        }
    }
    
    func drawTriangles(array: [Triangle]) {
        self.triangleView.layer.sublayers = nil
        var minCount = 0
        
        for triangle in array {
            if triangle.isMinimal && triangle.area > kMinimumTriangleSize {
                minCount += 1
                
                if !dontDrawTriangles {
                    guard let vertex1 = triangle.intersection1, let vertex2 = triangle.intersection2, let vertex3 = triangle.intersection3 else {
                        return
                    }
                    
                    let path = CGMutablePath()
                    path.move(to: vertex1)
                    path.addLine(to: vertex2)
                    path.addLine(to: vertex3)
                    path.addLine(to: vertex1)
                    
                    let shape = CAShapeLayer()
                    shape.frame = self.triangleView.bounds
                    shape.path = path
                    shape.strokeColor = UIColor.black.cgColor
                    shape.lineWidth = kTriangleStrokeBufferWidth
                    shape.fillColor = UIColor.red.cgColor
                    
                    if let color = triangle.color {
                        shape.fillColor = color.cgColor
                    }
                    
                    self.triangleView.layer.insertSublayer(shape, at: 0)
                }
            }
        }
        
        self.numberOfTriangles = minCount
        
        if minCount > maxTriangles {
            maxTriangles = minCount
            maxLines = [lineArr[lineArr.count-1]]
        }
    }
    
    func drawVertices(x: CGFloat, y: CGFloat) {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * kVertexRadius, height: 2.0 * kVertexRadius), cornerRadius: kVertexRadius).cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 2.0 * kVertexRadius, height: 2.0 * kVertexRadius)
        circleLayer.contentsGravity = "center";
        circleLayer.position = CGPoint(x: x+kVertexRadius, y: y+kVertexRadius)
        circleLayer.opacity = 0.5
        self.vertexView.layer.addSublayer(circleLayer)
        
        if (!undoFrameRefresh) {
            CATransaction.begin()
            let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = kAnimationDuration
            scaleAnimation.repeatCount = 0
            scaleAnimation.fromValue = 0
            scaleAnimation.toValue = kSwollenVertexScaleFactor
            scaleAnimation.fillMode = kCAFillModeForwards
            scaleAnimation.isRemovedOnCompletion = false
            
            CATransaction.setCompletionBlock {
                let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
                scaleAnimation.duration = self.kAnimationDuration
                scaleAnimation.repeatCount = 0
                scaleAnimation.fromValue = self.kSwollenVertexScaleFactor
                scaleAnimation.toValue = 1
                scaleAnimation.fillMode = kCAFillModeForwards
                scaleAnimation.isRemovedOnCompletion = false
                circleLayer.add(scaleAnimation, forKey: "scale")
                circleLayer.position = CGPoint(x: x+self.kVertexRadius, y: y+self.kVertexRadius)
            }
            
            circleLayer.add(scaleAnimation, forKey: "scale")
            circleLayer.position = CGPoint(x: x+kVertexRadius, y: y+kVertexRadius)
            CATransaction.commit()
        }
    }
    
    // Helper functions
    func removeLayerFromView(by id: Int, view: UIView) {
        if let layers = view.layer.sublayers {
            for case let layer in layers {
                if layer.name == "\(id)" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func calculateMaxTriangles() {
        self.dontDrawTriangles = true
        for i in stride(from: 0, to: UIScreen.main.bounds.size.width, by: 30) {
            for j in stride(from: 0, to: UIScreen.main.bounds.size.height / 2, by: 30) {
                self.drawLine(fromPoint: CGPoint(x: i, y: j), toPoint: CGPoint(x: UIScreen.main.bounds.size.width - i, y: UIScreen.main.bounds.size.height - j), doneDrawingLine: true)
                /*for k in stride(from: 0, to: UIScreen.main.bounds.size.width, by: 30) {
                 for l in stride(from: 0, to: UIScreen.main.bounds.size.height / 2, by: 30) {
                 sketchView.drawLine(fromPoint: CGPoint(x: k, y: l), toPoint: CGPoint(x: UIScreen.main.bounds.size.width - k, y: UIScreen.main.bounds.size.height - l), doneDrawingLine: true)
                 sketchView.undo()
                 }
                 }*/
                self.clearAll()
            }
        }
        self.dontDrawTriangles = false
        
        for line in self.maxLines {
            self.drawLine(fromPoint: line.start!, toPoint: line.end!, doneDrawingLine: true)
        }
    }
    
    func addParallaxToView(vw: UIView) {
        let amount = 10
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
    
}
