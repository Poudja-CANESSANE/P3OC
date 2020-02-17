//
//  WarningMessage.swift
//  P3OC
//
//  Created by Canessane Poudja on 04/02/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

func printWarning(msg: String) {  //Encompass the message with caution signs
    print("\n⚠️ \(msg) ⚠️\n")
}

func printDetailedDescription(of warrior: Warrior) {  //It prints the detailed description of a warrior
    print("\(warrior.positionInTeam). \(warrior.name) (type: \(warrior.type.description) \(warrior.type), health points 💚: \(warrior.hp), weapon 🪓: \(warrior.weapon.description), inflicted damage 💥: \(warrior.weapon.damage), magic points 💊: \(warrior.magicPoints))")
}

func printWarrior(_ warrior: Warrior) -> String {  //Print the emoji of the warrior's type and his name
    return "\(warrior.type.description) \(warrior.name)"
}
