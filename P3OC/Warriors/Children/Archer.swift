//
//  Archer.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Archer: Warrior {
    
    private let archerWeapons: [Weapon] = [.dummyGun, .lightBow, .bow, .heavyBow, .bazooka]  //A warrior of type archer can only use these wepons
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        super.init(positionInTeam: positionInTeam, type: type, name: name, weapons: archerWeapons, weapon: .bow, magicPoints: 20)
    }
}
