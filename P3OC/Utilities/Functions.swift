//
//  WarningMessage.swift
//  P3OC
//
//  Created by Canessane Poudja on 04/02/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

///Encompass the message with caution signs
func printWarning(msg: String) {
    print("\n⚠️ \(msg) ⚠️\n")
}

///It prints the detailed description of a warrior
func printDetailedDescription(of warrior: Warrior) {
    print("\(warrior.positionInTeam). \(warrior.name) (type: \(warrior.type.description) \(warrior.type), health points 💚: \(warrior.hp)/\(warrior.maxHp), weapon 🪓: \(warrior.weapon.description), inflicted damage 💥: \(warrior.weapon.damage), magic points 💊: \(warrior.magicPoints))")
}

///Print the emoji of the warrior's type and his name
func printWarrior(_ warrior: Warrior) -> String {
    return "\(warrior.type.description) \(warrior.name)"
}
