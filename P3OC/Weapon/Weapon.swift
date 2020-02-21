//
//  Weapon.swift
//  P3OC
//
//  Created by Canessane Poudja on 05/02/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

enum Weapon {
    case dummyGun, lightStone, stone, heavyStone, lightSword, sword, heavySword, lightBow, bow, heavyBow, bazooka
    
    var damage: Int {
        switch self {
        case .dummyGun: return 10
        case .lightStone: return 20
        case .stone: return 30
        case .heavyStone: return 40
        case .lightSword: return 50
        case .sword: return 60
        case .heavySword: return 70
        case .lightBow: return 30
        case .bow: return 40
        case .heavyBow: return 50
        case .bazooka: return 100
        }
    }
    
    var description: String {
        switch self {
        case .dummyGun: return "dummy gun"
        case .lightStone: return "light stone"
        case .stone: return "stone"
        case .heavyStone: return "heavy stone"
        case .lightSword: return "light sword"
        case .sword: return "sword"
        case .heavySword: return "heavy sword"
        case .lightBow: return "light bow"
        case .bow: return "bow"
        case .heavyBow: return "heavy bow"
        case .bazooka: return "bazooka"
        }
    }
}
