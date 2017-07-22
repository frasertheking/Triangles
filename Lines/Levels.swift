//
//  Levels.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class Levels: NSObject {
    
    static let level0 = Level(levelId: 0, numberOfLinesProvided: 1, numberOfTrianglesRequired: 1, lines:
        [Line(id: -1, start: CGPoint(x: 185, y: 150), end: CGPoint(x: 65, y: 500)),
         Line(id: -1, start: CGPoint(x: 164, y: 150), end: CGPoint(x: 288, y: 500))])
    
    static let level1 = Level(levelId: 1, numberOfLinesProvided: 3, numberOfTrianglesRequired: 1, lines: nil)
    
    static let level2 = Level(levelId: 3, numberOfLinesProvided: 1, numberOfTrianglesRequired: 2, lines:
        [Line(id: -1, start: CGPoint(x: 100, y: 150), end: CGPoint(x: 100, y: 450)),
         Line(id: -1, start: CGPoint(x: 75, y: 425), end: CGPoint(x: 300, y: 425)),
         Line(id: -1, start: CGPoint(x: 275, y: 450), end: CGPoint(x: 275, y: 150)),
         Line(id: -1, start: CGPoint(x: 75, y: 175), end: CGPoint(x: 300, y: 175))])
    
    static let level3 = Level(levelId: 4, numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, lines:
        [Line(id: -1, start: CGPoint(x: 100, y: 150), end: CGPoint(x: 100, y: 450)),
         Line(id: -1, start: CGPoint(x: 75, y: 425), end: CGPoint(x: 300, y: 425)),
         Line(id: -1, start: CGPoint(x: 275, y: 450), end: CGPoint(x: 275, y: 150)),
         Line(id: -1, start: CGPoint(x: 75, y: 175), end: CGPoint(x: 300, y: 175))])
    
    static let levels: [Level] = [level0, level1, level2, level3]
}
