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
}
