//
//  UserDefaultsInteractor.swift
//  Lines
//
//  Created by Fraser King on 2017-08-12.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import Foundation

struct UserDefaultsInteractor {
    private init() {}
    
    fileprivate static let currentLevelKey: String = "currentLevel"
    
    static func setCurrentLevel(level: Int) {
        UserDefaults.standard.set(level, forKey: currentLevelKey)
    }
    
    static func getCurrentLevel() -> Int {
        if isKeyPresentInUserDefaults(key: currentLevelKey) {
            return UserDefaults.standard.integer(forKey: currentLevelKey)
        }
        
        // Initialize default value if key is not yet set
        UserDefaults.standard.set(0, forKey: currentLevelKey)
        return 0
        
    }
    
    static func updateLevelIfGreaterThanCurrent(level: Int) {
        if level > getCurrentLevel() {
            setCurrentLevel(level: level)
        }
    }
    
    fileprivate static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
