//
//  Line.swift
//  Lines
//
//  Created by Fraser King on 2017-06-15.
//  Copyright © 2017 Fraser King. All rights reserved.

import UIKit

class Line {
    var id: Int?
    var start: CGPoint?
    var end: CGPoint?
    var length: CGFloat? {
        get {
            guard let point1 = start else {
                return nil
            }
            
            guard let point2 = end else {
                return nil
            }
            
            return round(CGFloat(sqrt(pow((point2.x - point1.x), 2) + pow((point2.y - point1.y), 2))))
        }
    }
    var slope: CGFloat? {
        get {
            guard let point1 = start else {
                return nil
            }
            
            guard let point2 = end else {
                return nil
            }
            
            return round(CGFloat((point2.y - point1.y) / (point2.x - point1.x)))
        }
    }
    
    init(id: Int, start: CGPoint, end: CGPoint) {
        self.id = id
        self.start = start
        self.end = end
    }
}

extension Line {
    func intersectsWithLine(line2: (a: CGPoint, b: CGPoint)) -> Bool {
        if self.getIntersectionPointForLine(line2: (a: line2.a, b: line2.b)) != .zero {
            return true
        }
                
        return false
    }
    
    func getIntersectionPointForLine(line2: (a: CGPoint, b: CGPoint)) -> CGPoint {
        guard let start = self.start else {
            return .zero
        }
        
        guard let end = self.end else {
            return .zero
        }
        
        let distance = (end.x - start.x) * (line2.b.y - line2.a.y) - (end.y - start.y) * (line2.b.x - line2.a.x)
        if distance == 0 {
            return .zero
        }
        
        let u = ((line2.a.x - start.x) * (line2.b.y - line2.a.y) - (line2.a.y - start.y) * (line2.b.x - line2.a.x)) / distance
        let v = ((line2.a.x - start.x) * (end.y - start.y) - (line2.a.y - start.y) * (end.x - start.x)) / distance
        
        if (u < 0.0 || u > 1.0) {
            return .zero
        }
        if (v < 0.0 || v > 1.0) {
            return .zero
        }
        
        return CGPoint(x: round(start.x + u * (end.x - start.x)), y: round(start.y + u * (end.y - start.y)))
    }
    
    func getIntersectionWithVertexCircle(intersectionPoint: CGPoint, intersectionArray: [CGPoint]) -> CGPoint? {
        for point in intersectionArray {
            if (pow((intersectionPoint.x - point.x), 2) + pow((intersectionPoint.y - point.y), 2) < 25) && point != intersectionPoint {
                return point
            }
        }
        
        return nil
    }
}
