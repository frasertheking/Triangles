//
//  Levels.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit

class Levels: NSObject {

    static let simple = Level(levelId: 0, image: "simple", numberOfLinesProvided: 1, numberOfTrianglesRequired: 1, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 150), end: CGPoint(x: 80, y: 500)),
         Line(id: -1, start: CGPoint(x: 175, y: 150), end: CGPoint(x: 300, y: 500))])
    
    static let triangle = Level(levelId: 1, image: "triangled", numberOfLinesProvided: 1, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 150), end: CGPoint(x: 80, y: 500)),
         Line(id: -1, start: CGPoint(x: 175, y: 150), end: CGPoint(x: 300, y: 500)),
         Line(id: -1, start: CGPoint(x: 60, y: 485), end: CGPoint(x: 310, y: 486))])
    
    static let twoLines = Level(levelId: 2, image: "twoLines", numberOfLinesProvided: 2, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 70.5, y: 201.0), end: CGPoint(x: 315.5, y: 201.5)),
         Line(id: -1, start: CGPoint(x: 70.5, y: 428.5), end: CGPoint(x: 315.5, y: 428.5))])
    
    static let box = Level(levelId: 3, image: "box", numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 100, y: 150), end: CGPoint(x: 100, y: 450)),
         Line(id: -1, start: CGPoint(x: 75, y: 425), end: CGPoint(x: 300, y: 425)),
         Line(id: -1, start: CGPoint(x: 275, y: 450), end: CGPoint(x: 275, y: 150)),
         Line(id: -1, start: CGPoint(x: 75, y: 175), end: CGPoint(x: 300, y: 175))])
    
    static let target = Level(levelId: 3, image: "target", numberOfLinesProvided: 3, numberOfTrianglesRequired: 6, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 62.5, y: 180), end: CGPoint(x: 300, y: 460)),
        Line(id: -1, start: CGPoint(x: 62.5, y: 460), end: CGPoint(x: 300, y: 180)),
        Line(id: -1, start: CGPoint(x: 181.5, y: 131.0), end: CGPoint(x: 182.0, y: 520.0))])
    
    static let noTri = Level(levelId: 3, image: "noTri", numberOfLinesProvided: 1, numberOfTrianglesRequired: 0, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 150), end: CGPoint(x: 80, y: 500)),
         Line(id: -1, start: CGPoint(x: 179, y: 150), end: CGPoint(x: 302, y: 500)),
         Line(id: -1, start: CGPoint(x: 75, y: 485), end: CGPoint(x: 315, y: 486)),
         Line(id: -1, start: CGPoint(x: 190, y: 150), end: CGPoint(x: 190, y: 500))])
    
    static let grid = Level(levelId: 4, image: "grid", numberOfLinesProvided: 2, numberOfTrianglesRequired: 8, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 78.0, y: 165.0), end: CGPoint(x: 76.0, y: 454.0)),
         Line(id: -1, start: CGPoint(x: 181.0, y: 161.0), end: CGPoint(x: 178.0, y: 459.5)),
         Line(id: -1, start: CGPoint(x: 274.0, y: 155.5), end: CGPoint(x: 273.0, y: 466.0)),
         Line(id: -1, start: CGPoint(x: 53.5, y: 208.0), end: CGPoint(x: 315.0, y: 213.0)),
         Line(id: -1, start: CGPoint(x: 44.5, y: 304.0), end: CGPoint(x: 311.5, y: 313.5)),
         Line(id: -1, start: CGPoint(x: 37.0, y: 400.0), end: CGPoint(x: 318.0, y: 408.5))])
    
    static let star3 = Level(levelId: 29, image: "star3", numberOfLinesProvided: 5, numberOfTrianglesRequired: 10, numberOfVerticesRequired: 10, lines:
        [Line(id: -1, start: CGPoint(x: 30.5, y: 292.5), end: CGPoint(x: 341.0, y: 294.0)),
         Line(id: -1, start: CGPoint(x: 183.0, y: 120.0), end: CGPoint(x: 289.5, y: 486.5)),
         Line(id: -1, start: CGPoint(x: 315.5, y: 466.0), end: CGPoint(x: 35.5, y: 271.5)),
         Line(id: -1, start: CGPoint(x: 357.0, y: 262.0), end: CGPoint(x: 91.0, y: 479.5)),
         Line(id: -1, start: CGPoint(x: 113.5, y: 494.5), end: CGPoint(x: 207.0, y: 120.0))])
    
    static let star2 = Level(levelId: 5, image: "star2", numberOfLinesProvided: 2, numberOfTrianglesRequired: 10, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 30.5, y: 292.5), end: CGPoint(x: 341.0, y: 294.0)),
         Line(id: -1, start: CGPoint(x: 183.0, y: 120.0), end: CGPoint(x: 289.5, y: 486.5)),
         Line(id: -1, start: CGPoint(x: 315.5, y: 466.0), end: CGPoint(x: 35.5, y: 271.5)),
         Line(id: -1, start: CGPoint(x: 357.0, y: 262.0), end: CGPoint(x: 91.0, y: 479.5)),
         Line(id: -1, start: CGPoint(x: 113.5, y: 494.5), end: CGPoint(x: 207.0, y: 120.0))])
    
    static let star1 = Level(levelId: 14, image: "star1", numberOfLinesProvided: 1, numberOfTrianglesRequired: 7, numberOfVerticesRequired: 12, lines:
        [Line(id: -1, start: CGPoint(x: 30.5, y: 292.5), end: CGPoint(x: 341.0, y: 294.0)),
         Line(id: -1, start: CGPoint(x: 183.0, y: 120.0), end: CGPoint(x: 289.5, y: 486.5)),
         Line(id: -1, start: CGPoint(x: 315.5, y: 466.0), end: CGPoint(x: 35.5, y: 271.5)),
         Line(id: -1, start: CGPoint(x: 357.0, y: 262.0), end: CGPoint(x: 91.0, y: 479.5)),
         Line(id: -1, start: CGPoint(x: 113.5, y: 494.5), end: CGPoint(x: 207.0, y: 120.0))])
    
    static let w = Level(levelId: 6, image: "w", numberOfLinesProvided: 3, numberOfTrianglesRequired: 9, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 59.0, y: 166.5), end: CGPoint(x: 141.5, y: 485.0)),
         Line(id: -1, start: CGPoint(x: 123.0, y: 485.0), end: CGPoint(x: 207.5, y: 166.5)),
         Line(id: -1, start: CGPoint(x: 184.5, y: 166.5), end: CGPoint(x: 265.0, y: 485.0)),
         Line(id: -1, start: CGPoint(x: 242.5, y: 485.0), end: CGPoint(x: 320.5, y: 166.5))])
    
    static let hard = Level(levelId: 7, image: "hard", numberOfLinesProvided: 3, numberOfTrianglesRequired: 7, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 208.0, y: 118.0), end: CGPoint(x: 285.5, y: 549.0)),
        Line(id: -1, start: CGPoint(x: 322.0, y: 439.0), end: CGPoint(x: 52.5, y: 438.5)),
        Line(id: -1, start: CGPoint(x: 110.5, y: 241.0), end: CGPoint(x: 363.0, y: 557.5))])
    
    static let realHard = Level(levelId: 8, image: "realHard", numberOfLinesProvided: 3, numberOfTrianglesRequired: 11, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 37.5, y: 153.0), end: CGPoint(x: 271.0, y: 530.5)),
        Line(id: -1, start: CGPoint(x: 331.5, y: 146.5), end: CGPoint(x: 102.0, y: 530.5)),
        Line(id: -1, start: CGPoint(x: 28.0, y: 171.5), end: CGPoint(x: 298.5, y: 407.5)),
        Line(id: -1, start: CGPoint(x: 346.5, y: 159.5), end: CGPoint(x: 82.0, y: 405.5))])
    
    static let splitTri = Level(levelId: 9, image: "splitTri", numberOfLinesProvided: 2, numberOfTrianglesRequired: 3, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 88.0, y: 204.0), end: CGPoint(x: 323.0, y: 207.0)),
         Line(id: -1, start: CGPoint(x: 342.5, y: 169.0), end: CGPoint(x: 155.0, y: 452.5)),
         Line(id: -1, start: CGPoint(x: 86.5, y: 181.0), end: CGPoint(x: 171.5, y: 511.0))])
    
    static let twoTriangles = Level(levelId: 10, image: "twoTriangles", numberOfLinesProvided: 3, numberOfTrianglesRequired: 2, numberOfVerticesRequired: 6, lines:
        [Line(id: -1, start: CGPoint(x: 76.5, y: 236.0), end: CGPoint(x: 202.0, y: 508.5)),
         Line(id: -1, start: CGPoint(x: 160.0, y: 512.0), end: CGPoint(x: 291.0, y: 289.0)),
         Line(id: -1, start: CGPoint(x: 60.5, y: 254.0), end: CGPoint(x: 320.0, y: 340.5))])
    
    static let splitBox = Level(levelId: 12, image: "splitBox", numberOfLinesProvided: 1, numberOfTrianglesRequired: 4, numberOfVerticesRequired: 6, lines:
        [Line(id: -1, start: CGPoint(x: 109.5, y: 263.5), end: CGPoint(x: 112.5, y: 430.5)),
        Line(id: -1, start: CGPoint(x: 93.0, y: 417.0), end: CGPoint(x: 274.0, y: 416.5)),
        Line(id: -1, start: CGPoint(x: 267.5, y: 429.5), end: CGPoint(x: 263.5, y: 260.0)),
        Line(id: -1, start: CGPoint(x: 98.5, y: 275.0), end: CGPoint(x: 278.0, y: 273.5)),
        Line(id: -1, start: CGPoint(x: 96.5, y: 262.5), end: CGPoint(x: 281.5, y: 431.0)),
        Line(id: -1, start: CGPoint(x: 273.5, y: 263.5), end: CGPoint(x: 102.0, y: 426.5))])
    
    static let cross = Level(levelId: 13, image: "cross", numberOfLinesProvided: 4, numberOfTrianglesRequired: 4, numberOfVerticesRequired: 12, lines:
        [Line(id: -1, start: CGPoint(x: 185.0, y: 165.5), end: CGPoint(x: 185.0, y: 519.5)),
         Line(id: -1, start: CGPoint(x: 54.5, y: 341.0), end: CGPoint(x: 324.0, y: 341.0))])
    
    static let killEx = Level(levelId: 14, image: "killEx", numberOfLinesProvided: 1, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 101.0, y: 336.5), end: CGPoint(x: 275.5, y: 192.5)),
         Line(id: -1, start: CGPoint(x: 248.5, y: 190.0), end: CGPoint(x: 279.0, y: 366.5)),
         Line(id: -1, start: CGPoint(x: 95.0, y: 314.5), end: CGPoint(x: 296.5, y: 347.0)),
         Line(id: -1, start: CGPoint(x: 204.5, y: 299.5), end: CGPoint(x: 180.0, y: 459.0))])
    
    // NEW LEVELS TO ADD
    
    static let penta = Level(levelId: 15, image: "penta", numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 225.0, y: 190), end: CGPoint(x: 70.0, y: 300.0)),
         Line(id: -1, start: CGPoint(x: 80.5, y: 264.5), end: CGPoint(x: 117.0, y: 442.5)),
         Line(id: -1, start: CGPoint(x: 90.5, y: 419.5), end: CGPoint(x: 300.0, y: 423.5)),
         Line(id: -1, start: CGPoint(x: 264.5, y: 448.0), end: CGPoint(x: 317.0, y: 248.0)),
         Line(id: -1, start: CGPoint(x: 336.0, y: 279.0), end: CGPoint(x: 190, y: 190))])
    
    static let axis = Level(levelId: 16, image: "axis", numberOfLinesProvided: 3, numberOfTrianglesRequired: 3, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 85.5, y: 146.5), end: CGPoint(x: 86.5, y: 453.0)),
         Line(id: -1, start: CGPoint(x: 57.5, y: 422.0), end: CGPoint(x: 333.5, y: 427.5))])
    
    static let slashes = Level(levelId: 18, image: "slashes", numberOfLinesProvided: 2, numberOfTrianglesRequired: 7, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 94.0, y: 231.0), end: CGPoint(x: 177.0, y: 526.0)),
        Line(id: -1, start: CGPoint(x: 128.0, y: 511.0), end: CGPoint(x: 283.0, y: 239.0)),
        Line(id: -1, start: CGPoint(x: 176.0, y: 244.5), end: CGPoint(x: 241.5, y: 482.5)),
        Line(id: -1, start: CGPoint(x: 94.0, y: 369.5), end: CGPoint(x: 168.0, y: 309.5)),
        Line(id: -1, start: CGPoint(x: 217.5, y: 268.5), end: CGPoint(x: 168.5, y: 382.5)),
        Line(id: -1, start: CGPoint(x: 249.0, y: 224.5), end: CGPoint(x: 285.5, y: 387.0))])
    
    static let slopes = Level(levelId: 19, image: "slopes", numberOfLinesProvided: 3, numberOfTrianglesRequired: 4, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 62.0, y: 301.0), end: CGPoint(x: 190.0, y: 514.0)),
        Line(id: -1, start: CGPoint(x: 304.5, y: 283.0), end: CGPoint(x: 207.5, y: 383.5)),
        Line(id: -1, start: CGPoint(x: 107.5, y: 174.5), end: CGPoint(x: 291.5, y: 177.5))])
    
    static let innerTri = Level(levelId: 20, image: "innerTri", numberOfLinesProvided: 2, numberOfTrianglesRequired: 1, numberOfVerticesRequired: 6, lines:
        [Line(id: -1, start: CGPoint(x: 189.0, y: 116.0), end: CGPoint(x: 36.0, y: 353.0)),
        Line(id: -1, start: CGPoint(x: 153.5, y: 123.0), end: CGPoint(x: 346.0, y: 534.0)),
        Line(id: -1, start: CGPoint(x: 18.5, y: 314.5), end: CGPoint(x: 359.0, y: 495.0)),
        Line(id: -1, start: CGPoint(x: 168.5, y: 236.0), end: CGPoint(x: 237.0, y: 386.0))])
    
    static let lineBox = Level(levelId: 21, image: "lineBox", numberOfLinesProvided: 2, numberOfTrianglesRequired: 4, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 45, y: 300.0), end: CGPoint(x: 45.0, y: 434.0)),
        Line(id: -1, start: CGPoint(x: 28.5, y: 415.0), end: CGPoint(x: 331.0, y: 415.0)),
        Line(id: -1, start: CGPoint(x: 311.0, y: 434.0), end: CGPoint(x: 311.0, y: 300.0)),
        Line(id: -1, start: CGPoint(x: 25.5, y: 317.0), end: CGPoint(x: 331.0, y: 317.0)),
        Line(id: -1, start: CGPoint(x: 238.0, y: 191.0), end: CGPoint(x: 240.0, y: 341.0))])

    static let longTri = Level(levelId: 22, image: "longTri", numberOfLinesProvided: 3, numberOfTrianglesRequired: 5, numberOfVerticesRequired: 6, lines:
        [Line(id: -1, start: CGPoint(x: 44.0, y: 435.5), end: CGPoint(x: 161.0, y: 568.5)),
        Line(id: -1, start: CGPoint(x: 37.5, y: 475.0), end: CGPoint(x: 340.5, y: 144.0)),
        Line(id: -1, start: CGPoint(x: 326.5, y: 135.0), end: CGPoint(x: 137.0, y: 581.0))])

    static let last = Level(levelId: 23, image: "last", numberOfLinesProvided: 2, numberOfTrianglesRequired: 15, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 195.5, y: 112.5), end: CGPoint(x: 327.0, y: 571.5)),
        Line(id: -1, start: CGPoint(x: 214.5, y: 106.0), end: CGPoint(x: 134.5, y: 574.5)),
        Line(id: -1, start: CGPoint(x: 27.0, y: 200.0), end: CGPoint(x: 372.0, y: 243.0)),
        Line(id: -1, start: CGPoint(x: 102.0, y: 316.5), end: CGPoint(x: 371.5, y: 236.5)),
        Line(id: -1, start: CGPoint(x: 324.5, y: 130.5), end: CGPoint(x: 131.5, y: 571.5)),
        Line(id: -1, start: CGPoint(x: 17.5, y: 121.0), end: CGPoint(x: 348.0, y: 590.0))])
    
    static let box2 = Level(levelId: 24, image: "box2", numberOfLinesProvided: 2, numberOfTrianglesRequired: 0, numberOfVerticesRequired: 9, lines:
        [Line(id: -1, start: CGPoint(x: 100, y: 150), end: CGPoint(x: 100, y: 450)),
         Line(id: -1, start: CGPoint(x: 75, y: 425), end: CGPoint(x: 300, y: 425)),
         Line(id: -1, start: CGPoint(x: 275, y: 450), end: CGPoint(x: 275, y: 150)),
         Line(id: -1, start: CGPoint(x: 75, y: 175), end: CGPoint(x: 300, y: 175))])
    
    static let spin = Level(levelId: 25, image: "spin", numberOfLinesProvided: 3, numberOfTrianglesRequired: 4, numberOfVerticesRequired: 9, lines:
        [Line(id: -1, start: CGPoint(x: 94.0, y: 197.5), end: CGPoint(x: 304.0, y: 200.0)),
        Line(id: -1, start: CGPoint(x: 98.5, y: 238.5), end: CGPoint(x: 280.0, y: 364.5)),
        Line(id: -1, start: CGPoint(x: 88.0, y: 280.0), end: CGPoint(x: 109.0, y: 492.0))])

    static let triForce = Level(levelId: 26, image: "triForce", numberOfLinesProvided: 3, numberOfTrianglesRequired: 9, numberOfVerticesRequired: 10, lines:
        [Line(id: -1, start: CGPoint(x: 174.0, y: 126.5), end: CGPoint(x: 341.0, y: 478.0)),
        Line(id: -1, start: CGPoint(x: 203.5, y: 120.0), end: CGPoint(x: 46.0, y: 471.0)),
        Line(id: -1, start: CGPoint(x: 31.0, y: 429.5), end: CGPoint(x: 357.0, y: 435.0)),
        Line(id: -1, start: CGPoint(x: 298.0, y: 297.0), end: CGPoint(x: 214.5, y: 472.0)),
        Line(id: -1, start: CGPoint(x: 82.5, y: 287.5), end: CGPoint(x: 177.5, y: 475.0)),
        Line(id: -1, start: CGPoint(x: 113.0, y: 246.5), end: CGPoint(x: 280.0, y: 252.5))])
   
    static let house = Level(levelId: 27, image: "house", numberOfLinesProvided: 1, numberOfTrianglesRequired: 1, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 208.0, y: 150.0), end: CGPoint(x: 77.5, y: 315.0)),
        Line(id: -1, start: CGPoint(x: 192.5, y: 150.0), end: CGPoint(x: 304.5, y: 317.5)),
        Line(id: -1, start: CGPoint(x: 85.0, y: 300.0), end: CGPoint(x: 85.0, y: 505.0)),
        Line(id: -1, start: CGPoint(x: 300.0, y: 300.0), end: CGPoint(x: 300.0, y: 505.0)),
        Line(id: -1, start: CGPoint(x: 75.0, y: 500.0), end: CGPoint(x: 310.0, y: 500.0))])
    
    static let downTri = Level(levelId: 28, image: "downTri", numberOfLinesProvided: 3, numberOfTrianglesRequired: 6, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 46.0, y: 208.5), end: CGPoint(x: 330.5, y: 211.0)),
        Line(id: -1, start: CGPoint(x: 306.0, y: 188.0), end: CGPoint(x: 188.0, y: 492.5)),
        Line(id: -1, start: CGPoint(x: 66.5, y: 185.0), end: CGPoint(x: 217.0, y: 499.0))])
    
    static let humbleStar = Level(levelId: 28, image: "humbleStar", numberOfLinesProvided: 2, numberOfTrianglesRequired: 5, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 58.5, y: 234.0), end: CGPoint(x: 317.5, y: 238.0)),
         Line(id: -1, start: CGPoint(x: 313.0, y: 213.0), end: CGPoint(x: 49.5, y: 465.0)),
         Line(id: -1, start: CGPoint(x: 60.0, y: 481.0), end: CGPoint(x: 249.0, y: 124.5))])
    
    static let levels: [Level] = [simple, triangle, twoLines, house, axis, box, splitTri, longTri, box2, downTri, killEx, noTri, grid, humbleStar, twoTriangles, splitBox, cross, target, slopes, lineBox, innerTri, star1, triForce, slashes, penta, spin, star3, w, star2, hard, realHard, last]
    
    static let tutorialLevel = Level(levelId: 0, image: nil, numberOfLinesProvided: 2, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines:
        [Line(id: -1, start: CGPoint(x: 200, y: 25), end: CGPoint(x: 80, y: 325)),
         Line(id: -1, start: CGPoint(x: 175, y: 25), end: CGPoint(x: 300, y: 325))])
    
    // KOBON TRIAL     
    static let kobon1 = Level(levelId: 0, image: nil, numberOfLinesProvided: 3, numberOfTrianglesRequired: 1, numberOfVerticesRequired: -1, lines: nil)
    static let kobon2 = Level(levelId: 0, image: nil, numberOfLinesProvided: 4, numberOfTrianglesRequired: 2, numberOfVerticesRequired: -1, lines: nil)
    static let kobon3 = Level(levelId: 0, image: nil, numberOfLinesProvided: 5, numberOfTrianglesRequired: 5, numberOfVerticesRequired: -1, lines: nil)
    static let kobon4 = Level(levelId: 0, image: nil, numberOfLinesProvided: 6, numberOfTrianglesRequired: 7, numberOfVerticesRequired: -1, lines: nil)
    static let kobon5 = Level(levelId: 0, image: nil, numberOfLinesProvided: 7, numberOfTrianglesRequired: 11, numberOfVerticesRequired: -1, lines: nil)
    static let kobon6 = Level(levelId: 0, image: nil, numberOfLinesProvided: 8, numberOfTrianglesRequired: 15, numberOfVerticesRequired: -1, lines: nil)
    static let kobon7 = Level(levelId: 0, image: nil, numberOfLinesProvided: 9, numberOfTrianglesRequired: 21, numberOfVerticesRequired: -1, lines: nil)
    static let kobon8 = Level(levelId: 0, image: nil, numberOfLinesProvided: 10, numberOfTrianglesRequired: 26, numberOfVerticesRequired: -1, lines: nil)
    static let kobon9 = Level(levelId: 0, image: nil, numberOfLinesProvided: 11, numberOfTrianglesRequired: 33, numberOfVerticesRequired: -1, lines: nil)
    static let kobon10 = Level(levelId: 0, image: nil, numberOfLinesProvided: 12, numberOfTrianglesRequired: 39, numberOfVerticesRequired: -1, lines: nil)
    static let kobon11 = Level(levelId: 0, image: nil, numberOfLinesProvided: 13, numberOfTrianglesRequired: 47, numberOfVerticesRequired: -1, lines: nil)
    static let kobon12 = Level(levelId: 0, image: nil, numberOfLinesProvided: 14, numberOfTrianglesRequired: 55, numberOfVerticesRequired: -1, lines: nil)
    static let kobon13 = Level(levelId: 0, image: nil, numberOfLinesProvided: 15, numberOfTrianglesRequired: 65, numberOfVerticesRequired: -1, lines: nil)
    
    static let kobonLevels: [Level] = [kobon1, kobon2, kobon3, kobon4, kobon5, kobon6, kobon7, kobon8, kobon9, kobon10, kobon11, kobon12, kobon13]

}
