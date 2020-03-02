//
//  Magus.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Magus: Warrior {
    
    override class var maxHp: Int { 100 }
    override class var magicPoints: Int { 30 }
    
    
// MARK: - INTERNAL
    
// MARK: Properties
    
    ///A warrior of type magus can only use these weapons
    override var weapons: [Weapon] {
        let usableWeapons: [Weapon] = [.lightStone, .stone, .heavyStone]
        return super.weapons + usableWeapons
    }
    
// MARK: Inits
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .stone, magicPoints: Magus.magicPoints, maxHp: Magus.maxHp)
    }
}
