//
//  Magus.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Magus: Warrior {
    
    let magusWeapons: [Weapon] = [.dummyGun, .lightStone, .stone, .heavyStone, .bazooka]
    
    init(positionInTeam: Int, type: WarriorType, name: String, weapon: Weapon) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapons: magusWeapons, weapon: .stone, magicPoints: 30)
    }
}
