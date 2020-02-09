//
//  Magus.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Magus: Warrior {
    
    private let magusWeapons: [Weapon] = [.dummyGun, .lightStone, .stone, .heavyStone, .bazooka]  //A warrior of type magus can only use these wepons
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapons: magusWeapons, weapon: .stone, magicPoints: 30)
    }
}
