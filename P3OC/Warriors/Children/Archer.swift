//
//  Archer.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Archer: Warrior {
    
    private let archerWeapons: [Weapon] = [.dummyGun, .lightBow, .bow, .heavyBow, .bazooka]
    
    init(positionInTeam: Int, type: WarriorType, name: String, weapon: Weapon) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapons: archerWeapons, weapon: .bow, magicPoints: 20)
    }
}
