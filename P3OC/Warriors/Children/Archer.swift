//
//  Archer.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Archer: Warrior {
        
// MARK: - INTERNAL
    
// MARK: - Properties
    
    ///A warrior of type archer can only use these weapons
    override var weapons: [Weapon] {
        let usableWeapons: [Weapon] = [.lightBow, .bow, .heavyBow]
        return super.weapons + usableWeapons
    }
    
    ///A warrior of type archer cannot exceed 70
    override var maxHp: Int { 70 }
    
// MARK: - Inits
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .bow, magicPoints: 20, hp: 70)
    }
}
