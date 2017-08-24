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
    var numberOfVerticesRequired: Int?
    var lines: [Line]?
    var image: String?
    
    init(levelId: Int, image: String?, numberOfLinesProvided: Int, numberOfTrianglesRequired: Int, numberOfVerticesRequired: Int, lines: [Line]?) {
        self.levelId = levelId
        self.image = image
        self.numberOfLinesProvided = numberOfLinesProvided
        self.numberOfTrianglesRequired = numberOfTrianglesRequired
        self.numberOfVerticesRequired = numberOfVerticesRequired
        self.lines = lines
    }
}
