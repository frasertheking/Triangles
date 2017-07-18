//
//  SketchView.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class SketchView: UIView {
    
    // Interface outlets
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var vertexView: UIView!
    @IBOutlet weak var lineView: UIView!
    var tapGestureRecognizer: UITapGestureRecognizer!
    var delegate: GameViewController?
    
    // Constants
    fileprivate let kLineMax: Int = 99
    fileprivate let kVertexRadius: CGFloat = 5.0
    fileprivate let kMinimumTriangleSize: CGFloat = 100.0
    fileprivate let kAnimationDuration: TimeInterval = 0.2
    fileprivate let kSwollenVertexScaleFactor: CGFloat = 1.25
    fileprivate let kLineWidth: CGFloat = 4
    fileprivate let kLineColor: UIColor = UIColor.black
    
    // Global vars
    fileprivate var firstPoint: CGPoint?
    fileprivate var secondPoint: CGPoint?
    fileprivate var lineArr: [Line] = [Line]()
    fileprivate var triangleArray: [Triangle] = [Triangle]()
    fileprivate var intersectionArray: [CGPoint] = [CGPoint]()
    fileprivate var colorArray: [UIColor] = [UIColor]()
    fileprivate var lineCount: Int = 0
    fileprivate var lineStart: CGPoint?
    fileprivate var undoFrameRefresh: Bool = false
    
    // Public vars
    var numberOfTriangles: Int {
        get {
            return self.numberOfTriangles
        }
        set {
            self.delegate?.updateTriangleCount(newCount: newValue)
        }
    }
    
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
        
        // Seed colors
        for _ in 0 ... kLineMax {
            colorArray.append(UIColor.random())
        }
        
        // Setup gesture recognizer for pan gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    // Action Event Handlers
    func clearAll() {
        self.vertexView.layer.sublayers = nil
        self.lineView.layer.sublayers = nil

        lineCount = 0
        lineArr.removeAll(keepingCapacity: false)
        intersectionArray.removeAll(keepingCapacity: false)
        findIntersections()
    }
    
    func undo() {
        if (lineCount > 0) {
             lineCount -= 1
             
             removeLayerFromView(by: lineCount, view: lineView)
             lineArr.removeLast()
             intersectionArray.removeAll(keepingCapacity: false)
             self.vertexView.layer.sublayers = nil
             undoFrameRefresh = true
             findIntersections()
        }
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        if panGesture.state == .began {
            lineStart = panGesture.location(in: self)
        }
        
        if panGesture.state == .ended {
            if let lineStart = lineStart {
                drawLine(fromPoint: lineStart, toPoint: panGesture.location(in: self), doneDrawingLine: true)
            }
        }
        
        if panGesture.state == .changed {
            if let lineStart = lineStart {
                drawLine(fromPoint: lineStart, toPoint: panGesture.location(in: self), doneDrawingLine: false)
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
                        for point in intersectionArray {
                            if (pow((intersectionPoint.x - point.x), 2) + pow((intersectionPoint.y - point.y), 2) < pow(kVertexRadius, 2)) && point != intersectionPoint {
                                intersectionPoint = point
                            }
                        }
                        
                        if intersectionArray.index(of: intersectionPoint) == nil {
                            intersectionArray.append(intersectionPoint)
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
        let minArray = Triangle.markMaximumTrianglesInArray(array: triangleArray)
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
                
                guard let vertex1 = triangle.vertex1, let vertex2 = triangle.vertex2, let vertex3 = triangle.vertex3 else {
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
                shape.fillColor = colorArray[minCount].cgColor
                
                self.triangleView.layer.insertSublayer(shape, at: 0)
            }
        }
        
        self.numberOfTriangles = minCount
    }
    
    func drawVertices(x: CGFloat, y: CGFloat) {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * kVertexRadius, height: 2.0 * kVertexRadius), cornerRadius: kVertexRadius).cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 2.0 * kVertexRadius, height: 2.0 * kVertexRadius)
        circleLayer.contentsGravity = "center";
        circleLayer.position = CGPoint(x: x+kVertexRadius, y: y+kVertexRadius)
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
    
}
