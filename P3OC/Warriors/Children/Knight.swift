//
//  Knight.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Knight: Warrior {
    
    override var weapons: [Weapon] {  //A warrior of type kinght can only use these weapons
        let newWeapons: [Weapon] = [.lightSword, .sword, .heavySword]
        return super.weapons + newWeapons
    }
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapon: .sword, magicPoints: 10)
    }
}
