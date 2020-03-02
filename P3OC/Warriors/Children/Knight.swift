//
//  Knight.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Knight: Warrior {
    
    override class var maxHp: Int { 50 }
    override class var magicPoints: Int { 10 }
        
// MARK: - INTERNAL
    
// MARK: Properties
    
    ///A warrior of type knight can only use these weapons
    override var weapons: [Weapon] {
        let usableWeapons: [Weapon] = [.lightSword, .sword, .heavySword]
        return super.weapons + usableWeapons
    }

// MARK: Inits
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .sword, magicPoints: Knight.magicPoints, maxHp: Knight.maxHp)
    }
}
