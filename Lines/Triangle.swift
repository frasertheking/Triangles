//
//  Triangle.swift
//  Lines
//
//  Created by Fraser King on 2017-07-09.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class Triangle {
    var vertex1: CGPoint?
    var vertex2: CGPoint?
    var vertex3: CGPoint?
    var line1: Line?
    var line2: Line?
    var line3: Line?
    var area: CGFloat? {
        get {
            let part1 = (vertex1?.x)!*((vertex1?.y)!-(vertex2?.y)!)
            let part2 = (vertex2?.x)!*((vertex3?.y)!-(vertex1?.y)!)
            let part3 = (vertex3?.x)!*((vertex1?.y)!-(vertex2?.y)!)
            return abs(0.5*(part1 + part2 + part3))
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
    
//    func getTriangleArea(line1: Line, line2: Line, line3: Line) -> CGFloat {
//        let vertex1: CGPoint = line1.getIntersectionPointForLine(line2: (a: line2.start!, b: line2.end!))
//        let vertex2: CGPoint = line1.getIntersectionPointForLine(line2: (a: line3.start!, b: line3.end!))
//        let vertex3: CGPoint = line2.getIntersectionPointForLine(line2: (a: line3.start!, b: line3.end!))
//    }
}
