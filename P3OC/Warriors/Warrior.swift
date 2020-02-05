//
//  Warrior.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Warrior {
    
//=================
// MARK: - Properties
//=================
    
    let positionInTeam: Int  //To know which warrior is selected
    let type: WarriorType  //This is the warrior's type
    let name: String  //This is the warrior's name
    var hp: Int = 100 {  //This is the warrior's life
        didSet {
            if hp > maxHp {
                hp = maxHp
            } else if !isAlive {
                hp = 0
            }
        }
    }
    let maxHp: Int = 100
    var weaponDamage: Int = 1 //This is the damage of a weapon
    var magicPoints: Int = 1  //This is how much the target hp can be heal by the warrior
    var isAlive: Bool { hp > 0 }

//============
// MARK: - Inits
//============
    init(positionInTeam: Int, type: WarriorType, name: String, weaponDamage: Int, magicPoints: Int) {
        self.positionInTeam = positionInTeam
        self.type = type
        self.name = name
        self.weaponDamage = weaponDamage
        self.magicPoints = magicPoints
    }

//=========================
// MARK: - METHODS - INTERNAL
//=========================
    
    func describe() {  //Describe the warrior with his position in the team and his name
        print("Your warrior 🏋️ N°\(positionInTeam) is of type \(type.description) \(type) and his name is \(name).")
    }
}
