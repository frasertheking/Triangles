//
//  Triangle.swift
//  Lines
//
//  Created by Fraser King on 2017-07-09.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class Triangle {
    var id: Int?
    var vertex1: CGPoint?
    var vertex2: CGPoint?
    var vertex3: CGPoint?
    var line1: Line?
    var line2: Line?
    var line3: Line?
    var isMinimal = true
    var semiPerimeter: CGFloat {
        get {
            
            guard let vertex1 = vertex1 else {
                return 0
            }
            
            guard let vertex2 = vertex2 else {
                return 0
            }
            
            guard let vertex3 = vertex3 else {
                return 0
            }
            
            let len1: CGFloat = CGFloat(sqrt(pow((vertex2.x - vertex1.x), 2) + pow((vertex2.y - vertex1.y), 2)))
            let len2: CGFloat = CGFloat(sqrt(pow((vertex2.x - vertex3.x), 2) + pow((vertex2.y - vertex3.y), 2)))
            let len3: CGFloat = CGFloat(sqrt(pow((vertex3.x - vertex1.x), 2) + pow((vertex3.y - vertex1.y), 2)))
            return (len1 + len2 + len3) / 2.0
        }
    }
    var area: CGFloat {
        get {
            
            guard let vertex1 = vertex1 else {
                return 0
            }
            
            guard let vertex2 = vertex2 else {
                return 0
            }
            
            guard let vertex3 = vertex3 else {
                return 0
            }
            
            let len1: CGFloat = CGFloat(sqrt(pow((vertex2.x - vertex1.x), 2) + pow((vertex2.y - vertex1.y), 2)))
            let len2: CGFloat = CGFloat(sqrt(pow((vertex2.x - vertex3.x), 2) + pow((vertex2.y - vertex3.y), 2)))
            let len3: CGFloat = CGFloat(sqrt(pow((vertex3.x - vertex1.x), 2) + pow((vertex3.y - vertex1.y), 2)))
            return sqrt(semiPerimeter*(semiPerimeter - len1)*(semiPerimeter - len2)*(semiPerimeter - len3))
        }
    }
    
    init(vertex1: CGPoint, vertex2: CGPoint, vertex3: CGPoint, line1: Line, line2: Line, line3: Line) {
        self.vertex1 = vertex1
        self.vertex2 = vertex2
        self.vertex3 = vertex3
        self.line1 = line1
        self.line2 = line2
        self.line3 = line3
    }
    
    func hasLine(line: Line) -> Bool {
        return line1!.id == line.id || line2!.id == line.id || line3!.id == line.id
    }
    
    func getCenter() -> CGPoint {
        let centerX: CGFloat = (self.vertex1!.x + self.vertex2!.x + self.vertex3!.x) / 3;
        let centerY: CGFloat = (self.vertex1!.y + self.vertex2!.y + self.vertex3!.y) / 3;
        return CGPoint(x: centerX, y: centerY)
    }
    
    func isPointInTriangle(p: CGPoint) -> Bool {
        guard let vertex1 = vertex1 else {
            return false
        }
        
        guard let vertex2 = vertex2 else {
            return false
        }
        
        guard let vertex3 = vertex3 else {
            return false
        }
        
        let A = 1/2 * (-vertex2.y * vertex3.x + vertex1.y * (-vertex2.x + vertex3.x) + vertex1.x * (vertex2.y - vertex3.y) + vertex2.x * vertex3.y)
        let sign: CGFloat = A < 0 ? -1 : 1
        
        let x = vertex1.y * vertex3.x - vertex1.x * vertex3.y
        let y = (vertex1.x - vertex3.x) * p.y
        let s = (x + (vertex3.y - vertex1.y) * p.x + y) * sign
        
        let q = vertex1.x * vertex2.y - vertex1.y * vertex2.x
        let r = (vertex2.x - vertex1.x) * p.y
        
        let t = (q + (vertex1.y - vertex2.y) * p.x + r) * sign
        return s > 0 && t > 0 && (s + t) < 2 * A * sign
    }
    
    // Class functions    
    class func getTriangleFromLines(lines: [Line], currentLine: Line, intersectionArray: [CGPoint], currentTriangles: [Triangle]) -> [Triangle]? {
        var triangleArr: [Triangle] = [Triangle]()
        for i in 0 ..< lines.count {
            for j in i+1 ..< lines.count {
                if let lineStartJ = lines[j].start, let lineEndJ = lines[j].end, let lineStartI = lines[i].start, let lineEndI = lines[i].end {
                    
                    if lines[i].intersectsWithLine(line2: (a: lineStartJ, b: lineEndJ)) {
                        
                        var vertex1 = currentLine.getIntersectionPointForLine(line2: (a: lineStartI, b: lineEndI))
                        var vertex2 = currentLine.getIntersectionPointForLine(line2: (a: lineStartJ, b: lineEndJ))
                        var vertex3 = lines[i].getIntersectionPointForLine(line2: (a: lineStartJ, b: lineEndJ))
                        
                        if let vertex1InCircle = currentLine.getIntersectionWithVertexCircle(intersectionPoint: vertex1, intersectionArray: intersectionArray) {
                            vertex1 = vertex1InCircle
                        }
                        
                        if let vertex2InCircle = currentLine.getIntersectionWithVertexCircle(intersectionPoint: vertex2, intersectionArray: intersectionArray) {
                            vertex2 = vertex2InCircle
                        }
                        
                        if let vertex3InCircle = currentLine.getIntersectionWithVertexCircle(intersectionPoint: vertex3, intersectionArray: intersectionArray) {
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
            let results = currentTriangles.filter { $0.vertex1 == triangle.vertex1 && $0.vertex2 == triangle.vertex2 && $0.vertex3 == triangle.vertex3 }
            if results.isEmpty {
                returnTriangles.append(triangle)
            }
        }
        
        if returnTriangles.count > 0 {
            return returnTriangles
        }
        
        return nil
    }
    
    class func markMaximumTrianglesInArray(array: [Triangle]) -> [Triangle] {
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
}
