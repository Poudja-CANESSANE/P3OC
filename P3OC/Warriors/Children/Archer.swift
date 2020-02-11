//
//  Archer.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Archer: Warrior {
    
    override var weapons: [Weapon] {
        let newWeapons: [Weapon] = [.lightBow, .bow, .heavyBow]
        return super.weapons + newWeapons
    }  //A warrior of type archer can only use these weapons
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .bow, magicPoints: 20)
    }
}
