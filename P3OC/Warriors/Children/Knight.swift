//
//  Knight.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Knight: Warrior {
    
    private let knightWeapons: [Weapon] = [.dummyGun, .lightSword, .sword, .heavySword, .bazooka]
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapons: knightWeapons, weapon: .sword, magicPoints: 10)
    }
}
