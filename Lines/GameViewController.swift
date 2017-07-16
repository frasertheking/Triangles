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
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var vertexView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var triangleCountLabel: UILabel!
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    // Constants
    let kLineMax: Int = 99
    let kVertexRadius: CGFloat = 5.0
    let kMinimumTriangleSize: CGFloat = 100.0
    
    // Global vars
    var firstPoint: CGPoint?
    var secondPoint: CGPoint?
    var lineArr: [Line] = [Line]()
    var triangleArray: [Triangle] = [Triangle]()
    var intersectionArray: [CGPoint] = [CGPoint]()
    var colorArray: [UIColor] = [UIColor]()
    var lineCount: Int = 0
    var lineStart: CGPoint?
    var undoFrameRefresh: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Seed colors
        for _ in 0 ... kLineMax {
            colorArray.append(UIColor.random())
        }
        
        // Setup gesture recognizer for pan gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Action Event Handlers
    @IBAction func clearPressed(sender: UIButton) {
        self.vertexView.layer.sublayers = nil
        self.lineView.layer.sublayers = nil
        
        lineCount = 0
        lineArr.removeAll(keepingCapacity: false)
        intersectionArray.removeAll(keepingCapacity: false)
        findIntersections()
    }
    
    @IBAction func undoPressed(sender: UIButton) {
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
            lineStart = panGesture.location(in: view)
        }
        
        if panGesture.state == .ended {
            if let lineStart = lineStart {
                addLine(fromPoint: lineStart, toPoint: panGesture.location(in: view), doneDrawingLine: true)
            }
        }
        
        if panGesture.state == .changed {
            if let lineStart = lineStart {
                addLine(fromPoint: lineStart, toPoint: panGesture.location(in: view), doneDrawingLine: false)
            }
        }
    }
    
    // Line drawing function
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint, doneDrawingLine: Bool) {
        let roundedStart = CGPoint(x: round(start.x), y: round(start.y))
        let roundedEnd = CGPoint(x: round(end.x), y: round(end.y))

        removeLayerFromView(by: lineCount, view: lineView)
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: roundedStart)
        linePath.addLine(to: roundedEnd)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.black.cgColor
        line.lineWidth = 4
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

    // Line intersection function
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
                            drawVertexLayer(x: intersectionPoint.x - kVertexRadius, y: intersectionPoint.y - kVertexRadius)
                        }
                    }
                    
                    if let triangles: [Triangle] = getTriangleFromLines(lines: intersectionArr, currentLine: lineArr[i]) {
                        for triangle in triangles {
                            triangleArray.append(triangle)
                        }
                    }
                }
            }
        }
        
        // Remove maximum triangles from the triangle array
        let minArray = markMaximumTrianglesInArray(array: triangleArray)
        drawTriangles(array: minArray)
    }
    
    func markMaximumTrianglesInArray(array: [Triangle]) -> [Triangle] {
        var sortedArray = array.sorted(by: { $0.area < $1.area })
        
        for i in 0 ..< sortedArray.count {
            for j in 0 ..< sortedArray.count {
                let triangleCenter: CGPoint = sortedArray[i].getCenter()
                if sortedArray[j].isPointInTriangle(p: triangleCenter) && sortedArray[j].area != sortedArray[i].area && sortedArray[i].isMinimal {
                    sortedArray[j].isMinimal = false
                }
            }
        }

        
        return sortedArray
    }
    
    func getTriangleFromLines(lines: [Line], currentLine: Line) -> [Triangle]? {
        var triangleArr: [Triangle] = [Triangle]()
        for i in 0 ..< lines.count {
            for j in i+1 ..< lines.count {
                if let lineStartJ = lines[j].start, let lineEndJ = lines[j].end, let lineStartI = lines[i].start, let lineEndI = lines[i].end {

                    if lines[i].intersectsWithLine(line2: (a: lineStartJ, b: lineEndJ)) {
                        
                        var vertex1 = currentLine.getIntersectionPointForLine(line2: (a: lineStartI, b: lineEndI))
                        var vertex2 = currentLine.getIntersectionPointForLine(line2: (a: lineStartJ, b: lineEndJ))
                        var vertex3 = lines[i].getIntersectionPointForLine(line2: (a: lineStartJ, b: lineEndJ))
                        
                        if let vertex1InCircle = currentLine.getIntersectionWithVertexCircle(intersectionPoint: vertex1, intersectionArray: self.intersectionArray) {
                            vertex1 = vertex1InCircle
                        }
                        
                        if let vertex2InCircle = currentLine.getIntersectionWithVertexCircle(intersectionPoint: vertex2, intersectionArray: self.intersectionArray) {
                            vertex2 = vertex2InCircle
                        }
                        
                        if let vertex3InCircle = currentLine.getIntersectionWithVertexCircle(intersectionPoint: vertex3, intersectionArray: self.intersectionArray) {
                            vertex3 = vertex3InCircle
                        }
                        
                        triangleArr.append(Triangle(vertex1: vertex1,
                                                    vertex2: vertex2,
                                                    vertex3: vertex3,
                                                      line1: currentLine,
                                                      line2: lines[i],
                                                      line3: lines[j]))
                    }
                }
            }
        }
        
        let sortedTriangles = triangleArr.sorted(by: { $0.area < $1.area })
        var returnTriangles: [Triangle] = [Triangle]()
        for triangle in sortedTriangles {
            let results = triangleArray.filter { $0.vertex1 == triangle.vertex1 && $0.vertex2 == triangle.vertex2 && $0.vertex3 == triangle.vertex3 }
            if results.isEmpty {
                returnTriangles.append(triangle)
            }
        }
        
        if returnTriangles.count > 0 {
            return returnTriangles
        }
        
        return nil
    }
    
    // Drawing functions
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
        
        triangleCountLabel.text = "\(minCount)"
    }
    
    func drawVertexLayer(x: CGFloat, y: CGFloat) {
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
            scaleAnimation.duration = 0.2
            scaleAnimation.repeatCount = 0
            scaleAnimation.fromValue = 0
            scaleAnimation.toValue = 1.25
            scaleAnimation.fillMode = kCAFillModeForwards
            scaleAnimation.isRemovedOnCompletion = false
            
            CATransaction.setCompletionBlock {
                let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
                scaleAnimation.duration = 0.2
                scaleAnimation.repeatCount = 0
                scaleAnimation.fromValue = 1.25
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
