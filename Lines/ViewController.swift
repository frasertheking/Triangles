//
//  ViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-06-15.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var triangleCountLabel: UILabel!
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    var firstPoint: CGPoint?
    var secondPoint: CGPoint?
    var lineArr: [Line] = [Line]()
    var triangleArray: [Triangle] = [Triangle]()
    var lineCount: Int = 0
    var lineStart: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.layer.name = "UI"
        undoButton.layer.name = "UI"
        triangleCountLabel.layer.name = "UI"
        triangleView.layer.name = "UI"
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func clearPressed(sender: UIButton) {

      /*  for case let layer in self.view.layer.sublayers! {
            if layer.name != "UI" {
                layer.removeFromSuperlayer()
            }
        }
        
        lineCount = 0
        lineArr.removeAll(keepingCapacity: false)
        findIntersections()*/
    }
    
    @IBAction func undoPressed(sender: UIButton) {
        if (lineCount > 0) {
            lineCount -= 1
            for case let layer in self.view.layer.sublayers! {
                if layer.name == "\(lineCount)" {
                    layer.removeFromSuperlayer()
                }
            }
            
            lineArr.removeLast()
            findIntersections()
        }
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {

        if panGesture.state == .began {
            print("Began", panGesture.location(in: view))
            lineStart = panGesture.location(in: view)
        }
        
        if panGesture.state == .ended {
            print("Ended", panGesture.location(in: view))
            addLine(fromPoint: lineStart!, toPoint: panGesture.location(in: view), done: true)

        }
        
        if panGesture.state == .changed {
            print("Changed", panGesture.location(in: view))
            addLine(fromPoint: lineStart!, toPoint: panGesture.location(in: view), done: false)

        }
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint, done: Bool) {
        
        for case let layer in self.view.layer.sublayers! {
            if layer.name == "\(lineCount)" {
                layer.removeFromSuperlayer()
            }
        }
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 5
        line.lineJoin = kCALineJoinRound
        line.name = "\(lineCount)"
        self.view.layer.addSublayer(line)
        
        if done {
            lineArr.append(Line(id: lineCount, start: start, end: end))
            lineCount += 1
            findIntersections()
        }
    }
    
    func findIntersections() {
        triangleArray = [Triangle]()
        for i in 0 ..< lineArr.count {
            var intersectionCount: Int = 0
            var intersectionArr: [Line] = [Line]()
            for j in i+1 ..< lineArr.count {
                if lineArr[i].intersectsWithLine(line2: (a: lineArr[j].start!, b: lineArr[j].end!)) {
                    intersectionCount += 1
                    intersectionArr.append(lineArr[j])
                }
                
                if let minimalTriangles: [Triangle] = getMinimalTriangleFromLines(lines: intersectionArr, currentLine: lineArr[i]) {
                    for triangle in minimalTriangles {
                        triangleArray.append(triangle)
                    }
                }
            }
        }
        
        let minArray = removeMaximumTrianglesFromArray(array: triangleArray)
        drawTriangles(array: minArray)
    }
    
    func removeMaximumTrianglesFromArray(array: [Triangle]) -> [Triangle] {
        var sortedArray = array.sorted(by: { $0.area! < $1.area! })
        
        for i in 0 ..< sortedArray.count {
            for j in 0 ..< sortedArray.count {
                let triangleCenter: CGPoint = getCenterFromTriangle(triangle: sortedArray[i])
                if isPointInTriangle(p: triangleCenter, p0: sortedArray[j].vertex1!, p1: sortedArray[j].vertex2!, p2: sortedArray[j].vertex3!) &&
                    sortedArray[j].area! != sortedArray[i].area! && sortedArray[i].isMinimal {
                    sortedArray[j].isMinimal = false
                }
            }
        }

        
        return sortedArray
    }
    
    func getCenterFromTriangle(triangle: Triangle) -> CGPoint {
        let centerX: CGFloat = (triangle.vertex1!.x + triangle.vertex2!.x + triangle.vertex3!.x) / 3;
        let centerY: CGFloat = (triangle.vertex1!.y + triangle.vertex2!.y + triangle.vertex3!.y) / 3;
        return CGPoint(x: centerX, y: centerY)
    }
    
    func isPointInTriangle(p: CGPoint, p0: CGPoint, p1: CGPoint, p2: CGPoint) -> Bool {
        let A = 1/2 * (-p1.y * p2.x + p0.y * (-p1.x + p2.x) + p0.x * (p1.y - p2.y) + p1.x * p2.y)
        let sign: CGFloat = A < 0 ? -1 : 1
        
        let x = p0.y * p2.x - p0.x * p2.y
        let y = (p0.x - p2.x) * p.y
        let s = (x + (p2.y - p0.y) * p.x + y) * sign
        
        let q = p0.x * p1.y - p0.y * p1.x
        let r = (p1.x - p0.x) * p.y
        
        let t = (q + (p0.y - p1.y) * p.x + r) * sign
        return s > 0 && t > 0 && (s + t) < 2 * A * sign
    }
    
    func getMinimalTriangleFromLines(lines: [Line], currentLine: Line) -> [Triangle]? {
        var triangleArr: [Triangle] = [Triangle]()
        for i in 0 ..< lines.count {
            for j in i+1 ..< lines.count {
                if lines[i].intersectsWithLine(line2: (a: lines[j].start!, b: lines[j].end!)) {
                    triangleArr.append(Triangle(vertex1: currentLine.getIntersectionPointForLine(line2: (a: lines[i].start!, b: lines[i].end!)),
                                                vertex2: currentLine.getIntersectionPointForLine(line2: (a: lines[j].start!, b: lines[j].end!)),
                                                vertex3: lines[i].getIntersectionPointForLine(line2: (a: lines[j].start!, b: lines[j].end!)),
                                                  line1: currentLine,
                                                  line2: lines[i],
                                                  line3: lines[j]))
                }
            }
        }
        
        let sortedTriangles = triangleArr.sorted(by: { $0.area! < $1.area! })
        var returnTriangles: [Triangle] = [Triangle]()
        for triangle in sortedTriangles {
            let results = triangleArray.filter { $0.vertex1 == triangle.vertex1 && $0.vertex2 == triangle.vertex2 && $0.vertex3 == triangle.vertex3 }
            if results.isEmpty {
                
                // Need to check if minimal
                
                returnTriangles.append(triangle)
            }
        }
        
        if returnTriangles.count > 0 {
            return returnTriangles
        }
        
        return nil
    }
    
    func drawTriangles(array: [Triangle]) {
        
        self.triangleView.layer.sublayers = nil
        var minCount = 0
        
        for triangle in array {
            if triangle.isMinimal {
                minCount += 1
                let path = CGMutablePath()
                path.move(to: triangle.vertex1!)
                path.addLine(to: triangle.vertex2!)
                path.addLine(to: triangle.vertex3!)
                path.addLine(to: triangle.vertex1!)
                
                let shape = CAShapeLayer()
                shape.frame = self.view.bounds
                shape.path = path
                shape.lineWidth = 3.0
                shape.fillColor = UIColor.red.withAlphaComponent(0.5).cgColor
                
                self.triangleView.layer.insertSublayer(shape, at: 0)
            }
        }
        
        triangleCountLabel.text = "\(minCount)"

    }
    
 
}
