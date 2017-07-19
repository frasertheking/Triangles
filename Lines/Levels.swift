//
//  Levels.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class Levels: NSObject {
    
    static let level0 = Level(levelId: 1, numberOfLinesProvided: 1, numberOfTrianglesRequired: 1, lines:
        [Line(id: -1, start: CGPoint(x: 185, y: 150), end: CGPoint(x: 65, y: 500)),
         Line(id: -1, start: CGPoint(x: 164, y: 150), end: CGPoint(x: 288, y: 500))])
    
    static let level1 = Level(levelId: 2, numberOfLinesProvided: 1, numberOfTrianglesRequired: 2, lines:
        [Line(id: -1, start: CGPoint(x: 50, y: 150), end: CGPoint(x: 50, y: 500)),
         Line(id: -1, start: CGPoint(x: 25, y: 475), end: CGPoint(x: 350, y: 475)),
         Line(id: -1, start: CGPoint(x: 325, y: 500), end: CGPoint(x: 325, y: 150)),
         Line(id: -1, start: CGPoint(x: 25, y: 175), end: CGPoint(x: 350, y: 175))])
    
    static let level2 = Level(levelId: 3, numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, lines:
        [Line(id: -1, start: CGPoint(x: 50, y: 150), end: CGPoint(x: 50, y: 500)),
         Line(id: -1, start: CGPoint(x: 25, y: 475), end: CGPoint(x: 350, y: 475)),
         Line(id: -1, start: CGPoint(x: 325, y: 500), end: CGPoint(x: 325, y: 150)),
         Line(id: -1, start: CGPoint(x: 25, y: 175), end: CGPoint(x: 350, y: 175))])
    
    static let levels: [Level] = [level0, level1, level2]
}
