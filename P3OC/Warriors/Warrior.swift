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
    var hp: Int = 100 {  //This is the warrior's life and it is between 0 and maxHp
        didSet {
            if hp > maxHp {
                hp = maxHp
            } else if !isAlive {
                hp = 0
            }
        }
    }
    let maxHp: Int = 100  //The warrior's life cannot exceed maxHp
    var weapon: Weapon  //This is the warrior's weapon
    var magicPoints: Int = 1  //This is how much the target's hp can be heal by the warrior
    var isAlive: Bool { hp > 0 }  //To know if the warrior is alive
    var weapons: [Weapon] { [.dummyGun, .bazooka] }   //This array contains all the weapons that the warrior can use
//============
// MARK: - Inits
//==============
    
    init(positionInTeam: Int, type: WarriorType, name: String, weapon: Weapon, magicPoints: Int) {
        self.positionInTeam = positionInTeam
        self.type = type
        self.name = name
        self.weapon = weapon
        self.magicPoints = magicPoints
    }

//=========================
// MARK: - METHODS - INTERNAL
//=========================
    
    func describe() {  //Describe the warrior with his position in the team, his type and his name
        print("Your warrior 🏋️ N°\(positionInTeam) is of type \(type.description) \(type) and his name is \(name).")
    }
}
