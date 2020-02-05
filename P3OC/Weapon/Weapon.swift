//
//  Weapon.swift
//  P3OC
//
//  Created by Canessane Poudja on 05/02/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

enum Weapon {
    case stone, sword, bow
    
    var damage: Int {
        switch self {
        case .stone: return 10
        case .sword: return 30
        case .bow: return 20
        }
    }
}
