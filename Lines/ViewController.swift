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
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    var firstPoint: CGPoint?
    var secondPoint: CGPoint?
    var lineArr: [Line] = [Line]()
    var lineCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showMoreActions(touch:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func showMoreActions(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        
        guard let _ = firstPoint else {
            firstPoint = touchPoint
            return
        }
        
        guard let _  = secondPoint else {
            secondPoint = touchPoint
            addLine(fromPoint: firstPoint!, toPoint: secondPoint!)
            
            firstPoint = nil
            secondPoint = nil
            
            return
        }
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
        lineArr.append(Line(id: lineCount, start: start, end: end))
        lineCount += 1
        findIntersections()
    }
    
    func findIntersections() {
        var triangleArray: [Triangle] = [Triangle]()
        for i in 0 ..< lineArr.count {
            var intersectionCount: Int = 0
            var intersectionArr: [Line] = [Line]()
            for j in i+1 ..< lineArr.count {
                if lineArr[i].intersectsWithLine(line2: (a: lineArr[j].start!, b: lineArr[j].end!)) {
                    intersectionCount += 1
                    intersectionArr.append(lineArr[j])
                }
                
                if let minimalTriangle: Triangle = getMinimalTriangleFromLines(lines: intersectionArr, currentLine: lineArr[i]) {

                    let results = triangleArray.filter { $0.vertex1 == minimalTriangle.vertex1 && $0.vertex2 == minimalTriangle.vertex2 && $0.vertex3 == minimalTriangle.vertex3 }
                    if results.isEmpty {
                        triangleArray.append(minimalTriangle)
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
            for j in i+1 ..< sortedArray.count {
                if (sortedArray[j].hasLine(line: sortedArray[i].line1!) && sortedArray[j].hasLine(line: sortedArray[i].line2!)) ||
                   (sortedArray[j].hasLine(line: sortedArray[i].line1!) && sortedArray[j].hasLine(line: sortedArray[i].line3!)) ||
                   (sortedArray[j].hasLine(line: sortedArray[i].line2!) && sortedArray[j].hasLine(line: sortedArray[i].line3!)) {
                    sortedArray[j].isMinimal = false
                }
            }
        }

        return sortedArray
    }
    
    func getMinimalTriangleFromLines(lines: [Line], currentLine: Line) -> Triangle? {
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
        if (sortedTriangles.count > 0) {
            return sortedTriangles[0]
        }
        
        return nil
    }
    
    func drawTriangles(array: [Triangle]) {
        
        self.triangleView.layer.sublayers = nil
        
        for triangle in array {
            if triangle.isMinimal {
                let path = CGMutablePath()
                path.move(to: triangle.vertex1!)
                path.addLine(to: triangle.vertex2!)
                path.addLine(to: triangle.vertex3!)
                path.addLine(to: triangle.vertex1!)
                
                let shape = CAShapeLayer()
                shape.frame = self.view.bounds
                shape.path = path
                shape.lineWidth = 3.0
                shape.fillColor = UIColor.red.cgColor
                
                self.triangleView.layer.insertSublayer(shape, at: 0)
            }
        }

    }
    
 
}
