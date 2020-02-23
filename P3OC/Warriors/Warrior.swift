//
//  Warrior.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Warrior {
    
// MARK: - INTERNAL
    
// MARK: - Properties

    ///To know which warrior is selected
    let positionInTeam: Int
    
    ///This is the warrior's type
    let type: WarriorType
    
    ///This is the warrior's name
    let name: String
    
    ///This is the warrior's weapon
    var weapon: Weapon
    
    ///This is how much the target's hp can be heal by the warrior
    var magicPoints: Int
    
    ///This is the warrior's life and it is between 0 and maxHp
    var hp: Int {
        didSet {
            if hp > maxHp {
                hp = maxHp
            } else if !isAlive {
                hp = 0
            }
        }
    }
    
    ///The warrior's life cannot exceed maxHp
    var maxHp: Int { 100 }
    
    ///To know if the warrior is alive
    var isAlive: Bool { hp > 0 }
    
    ///This array contains all the weapons that the warrior can use
    var weapons: [Weapon] { [.dummyGun, .bazooka] }

// MARK: - Inits
    
    init(positionInTeam: Int, type: WarriorType, name: String, weapon: Weapon, magicPoints: Int, hp: Int) {
        self.positionInTeam = positionInTeam
        self.type = type
        self.name = name
        self.weapon = weapon
        self.magicPoints = magicPoints
        self.hp = hp
    }

// MARK: - Methods
    
    ///Describe the warrior with his position in the team, his type and his name
    func describe() {
        print("Your warrior 🏋️ N°\(positionInTeam) is of type \(type.description) \(type) and his name is \(name).")
    }
}
