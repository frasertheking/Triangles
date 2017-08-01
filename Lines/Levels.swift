//
//  Levels.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class Levels: NSObject {

    static let a0 = Level(levelId: 0, numberOfLinesProvided: 1, numberOfTrianglesRequired: 1, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 150), end: CGPoint(x: 80, y: 500)),
         Line(id: -1, start: CGPoint(x: 175, y: 150), end: CGPoint(x: 300, y: 500))])
    
    static let a1 = Level(levelId: 1, numberOfLinesProvided: 1, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 150), end: CGPoint(x: 80, y: 500)),
         Line(id: -1, start: CGPoint(x: 175, y: 150), end: CGPoint(x: 300, y: 500)),
         Line(id: -1, start: CGPoint(x: 60, y: 485), end: CGPoint(x: 310, y: 486))])
    
    static let a2 = Level(levelId: 2, numberOfLinesProvided: 2, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 70.5, y: 201.0), end: CGPoint(x: 315.5, y: 201.5)),
         Line(id: -1, start: CGPoint(x: 70.5, y: 428.5), end: CGPoint(x: 315.5, y: 428.5))])
    
    static let a3 = Level(levelId: 3, numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 100, y: 150), end: CGPoint(x: 100, y: 450)),
         Line(id: -1, start: CGPoint(x: 75, y: 425), end: CGPoint(x: 300, y: 425)),
         Line(id: -1, start: CGPoint(x: 275, y: 450), end: CGPoint(x: 275, y: 150)),
         Line(id: -1, start: CGPoint(x: 75, y: 175), end: CGPoint(x: 300, y: 175))])
    
    static let a4 = Level(levelId: 3, numberOfLinesProvided: 3, numberOfTrianglesRequired: 6, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 62.5, y: 180), end: CGPoint(x: 300, y: 460)),
        Line(id: -1, start: CGPoint(x: 62.5, y: 460), end: CGPoint(x: 300, y: 180)),
        Line(id: -1, start: CGPoint(x: 181.5, y: 131.0), end: CGPoint(x: 182.0, y: 520.0))])
    
    static let b0 = Level(levelId: 3, numberOfLinesProvided: 1, numberOfTrianglesRequired: 0, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 150), end: CGPoint(x: 80, y: 500)),
         Line(id: -1, start: CGPoint(x: 179, y: 150), end: CGPoint(x: 302, y: 500)),
         Line(id: -1, start: CGPoint(x: 75, y: 485), end: CGPoint(x: 315, y: 486)),
         Line(id: -1, start: CGPoint(x: 190, y: 150), end: CGPoint(x: 190, y: 500))])
    
    static let a5 = Level(levelId: 4, numberOfLinesProvided: 2, numberOfTrianglesRequired: 8, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 78.0, y: 165.0), end: CGPoint(x: 76.0, y: 454.0)),
         Line(id: -1, start: CGPoint(x: 181.0, y: 161.0), end: CGPoint(x: 178.0, y: 459.5)),
         Line(id: -1, start: CGPoint(x: 274.0, y: 155.5), end: CGPoint(x: 273.0, y: 466.0)),
         Line(id: -1, start: CGPoint(x: 53.5, y: 208.0), end: CGPoint(x: 315.0, y: 213.0)),
         Line(id: -1, start: CGPoint(x: 44.5, y: 304.0), end: CGPoint(x: 311.5, y: 313.5)),
         Line(id: -1, start: CGPoint(x: 37.0, y: 400.0), end: CGPoint(x: 318.0, y: 408.5))])
    
    static let a6 = Level(levelId: 5, numberOfLinesProvided: 2, numberOfTrianglesRequired: 10, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 30.5, y: 292.5), end: CGPoint(x: 341.0, y: 294.0)),
         Line(id: -1, start: CGPoint(x: 183.0, y: 120.0), end: CGPoint(x: 289.5, y: 486.5)),
         Line(id: -1, start: CGPoint(x: 315.5, y: 466.0), end: CGPoint(x: 35.5, y: 271.5)),
         Line(id: -1, start: CGPoint(x: 357.0, y: 262.0), end: CGPoint(x: 91.0, y: 479.5)),
         Line(id: -1, start: CGPoint(x: 113.5, y: 494.5), end: CGPoint(x: 207.0, y: 120.0))])
    
    static let a12 = Level(levelId: 14, numberOfLinesProvided: 1, numberOfTrianglesRequired: 7, numberOfVerticesRequired: 12, lines:
        [Line(id: -1, start: CGPoint(x: 30.5, y: 292.5), end: CGPoint(x: 341.0, y: 294.0)),
         Line(id: -1, start: CGPoint(x: 183.0, y: 120.0), end: CGPoint(x: 289.5, y: 486.5)),
         Line(id: -1, start: CGPoint(x: 315.5, y: 466.0), end: CGPoint(x: 35.5, y: 271.5)),
         Line(id: -1, start: CGPoint(x: 357.0, y: 262.0), end: CGPoint(x: 91.0, y: 479.5)),
         Line(id: -1, start: CGPoint(x: 113.5, y: 494.5), end: CGPoint(x: 207.0, y: 120.0))])
    
    static let b1 = Level(levelId: 5, numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 62.5, y: 331.0), end: CGPoint(x: 327.5, y: 170.0)),
         Line(id: -1, start: CGPoint(x: 103.5, y: 273.5), end: CGPoint(x: 282.5, y: 534.0)),
         Line(id: -1, start: CGPoint(x: 115.0, y: 382.5), end: CGPoint(x: 340.5, y: 143.0))])
    
    static let a7 = Level(levelId: 6, numberOfLinesProvided: 3, numberOfTrianglesRequired: 9, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 59.0, y: 166.5), end: CGPoint(x: 141.5, y: 485.0)),
         Line(id: -1, start: CGPoint(x: 123.0, y: 485.0), end: CGPoint(x: 207.5, y: 166.5)),
         Line(id: -1, start: CGPoint(x: 184.5, y: 166.5), end: CGPoint(x: 265.0, y: 485.0)),
         Line(id: -1, start: CGPoint(x: 242.5, y: 485.0), end: CGPoint(x: 320.5, y: 166.5))])
    
    static let a8 = Level(levelId: 7, numberOfLinesProvided: 3, numberOfTrianglesRequired: 7, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 208.0, y: 118.0), end: CGPoint(x: 285.5, y: 549.0)),
        Line(id: -1, start: CGPoint(x: 322.0, y: 439.0), end: CGPoint(x: 52.5, y: 438.5)),
        Line(id: -1, start: CGPoint(x: 110.5, y: 241.0), end: CGPoint(x: 363.0, y: 557.5))])
    
    static let a9 = Level(levelId: 8, numberOfLinesProvided: 3, numberOfTrianglesRequired: 11, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 37.5, y: 153.0), end: CGPoint(x: 271.0, y: 530.5)),
        Line(id: -1, start: CGPoint(x: 331.5, y: 146.5), end: CGPoint(x: 102.0, y: 530.5)),
        Line(id: -1, start: CGPoint(x: 28.0, y: 171.5), end: CGPoint(x: 298.5, y: 407.5)),
        Line(id: -1, start: CGPoint(x: 346.5, y: 159.5), end: CGPoint(x: 82.0, y: 405.5))])
    
    static let a10 = Level(levelId: 9, numberOfLinesProvided: 2, numberOfTrianglesRequired: 3, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 88.0, y: 204.0), end: CGPoint(x: 323.0, y: 207.0)),
         Line(id: -1, start: CGPoint(x: 342.5, y: 169.0), end: CGPoint(x: 155.0, y: 452.5)),
         Line(id: -1, start: CGPoint(x: 86.5, y: 181.0), end: CGPoint(x: 171.5, y: 511.0))])
    
    static let v0 = Level(levelId: 10, numberOfLinesProvided: 3, numberOfTrianglesRequired: 2, numberOfVerticesRequired: 6, lines:
        [Line(id: -1, start: CGPoint(x: 76.5, y: 236.0), end: CGPoint(x: 202.0, y: 508.5)),
         Line(id: -1, start: CGPoint(x: 160.0, y: 512.0), end: CGPoint(x: 291.0, y: 289.0)),
         Line(id: -1, start: CGPoint(x: 60.5, y: 254.0), end: CGPoint(x: 320.0, y: 340.5))])
    
    static let v1 = Level(levelId: 12, numberOfLinesProvided: 1, numberOfTrianglesRequired: 4, numberOfVerticesRequired: 6, lines:
        [Line(id: -1, start: CGPoint(x: 109.5, y: 263.5), end: CGPoint(x: 112.5, y: 430.5)),
        Line(id: -1, start: CGPoint(x: 93.0, y: 417.0), end: CGPoint(x: 274.0, y: 416.5)),
        Line(id: -1, start: CGPoint(x: 267.5, y: 429.5), end: CGPoint(x: 263.5, y: 260.0)),
        Line(id: -1, start: CGPoint(x: 98.5, y: 275.0), end: CGPoint(x: 278.0, y: 273.5)),
        Line(id: -1, start: CGPoint(x: 96.5, y: 262.5), end: CGPoint(x: 281.5, y: 431.0)),
        Line(id: -1, start: CGPoint(x: 273.5, y: 263.5), end: CGPoint(x: 102.0, y: 426.5))])
    
    static let v2 = Level(levelId: 13, numberOfLinesProvided: 4, numberOfTrianglesRequired: 4, numberOfVerticesRequired: 12, lines:
        [Line(id: -1, start: CGPoint(x: 185.0, y: 165.5), end: CGPoint(x: 185.0, y: 519.5)),
         Line(id: -1, start: CGPoint(x: 54.5, y: 341.0), end: CGPoint(x: 324.0, y: 341.0))])

    
    static let levels: [Level] = [a0, a1, a2, a10, a3, b0, a5, v0, v1, v2, a4, a12, a7, a6, a8, a9]
}
