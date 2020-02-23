//
//  Knight.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Knight: Warrior {
        
// MARK: - INTERNAL
    
// MARK: - Properties
    
    ///A warrior of type knight can only use these weapons
    override var weapons: [Weapon] {
        let usableWeapons: [Weapon] = [.lightSword, .sword, .heavySword]
        return super.weapons + usableWeapons
    }
    
    ///A warrior of type knight cannot exceed 50
    override var maxHp: Int { 50 }

// MARK: - Inits
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .sword, magicPoints: 10, hp: 50)
    }
}
