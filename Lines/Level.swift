//
//  Level.swift
//  Lines
//
//  Created by Fraser King on 2017-07-17.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import Foundation

class Level: NSObject {
    var levelId: Int?
    var numberOfLinesProvided: Int?
    var numberOfTrianglesRequired: Int?
    var lines: [Line]?
    
    init(levelId: Int, numberOfLinesProvided: Int, numberOfTrianglesRequired: Int, lines: [Line]) {
        self.levelId = levelId
        self.numberOfLinesProvided = numberOfLinesProvided
        self.numberOfTrianglesRequired = numberOfTrianglesRequired
        self.lines = lines
    }
}
