//
//  Magus.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Magus: Warrior {
    
    override var weapons: [Weapon] {
        let newWeapons: [Weapon] = [.lightStone, .stone, .heavyStone]
        return super.weapons + newWeapons
    }  //A warrior of type magus can only use these weapons
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .stone, magicPoints: 30)
    }
}
