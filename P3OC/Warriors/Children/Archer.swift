//
//  Archer.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Archer: Warrior {
    
    override class var maxHp: Int { 70 }
    override class var magicPoints: Int { 20 }
        
// MARK: - INTERNAL
    
// MARK: Properties
    
    ///A warrior of type archer can only use these weapons
    override var weapons: [Weapon] {
        let usableWeapons: [Weapon] = [.lightBow, .bow, .heavyBow]
        return super.weapons + usableWeapons
    }
    
// MARK: Inits
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .bow, magicPoints: Archer.magicPoints, maxHp: Archer.maxHp)
    }
}
