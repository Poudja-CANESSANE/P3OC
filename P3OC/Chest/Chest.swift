//
//  Chest.swift
//  P3OC
//
//  Created by Canessane Poudja on 06/02/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Chest {

//===========================
// MARK: - METHODS - INTERNAL
//===========================
    
    func loopMakeAppearChestWithRandomWeapon(chosenWarrior: Warrior, actualWeapon: Weapon) -> Weapon {  //Return a random weapon from the weapons array of the chosen warrior while randomWeapon == actualWeapon
        var randomWeapon: Weapon = actualWeapon
        
        while randomWeapon == actualWeapon {
            randomWeapon = makeAppearChestWithRamdomWeapon(chosenWarrior: chosenWarrior)
        }
        return randomWeapon
    }
    
//==========================
// MARK: - METHODS - PRIVATE
//==========================
    
    private func makeAppearChestWithRamdomWeapon(chosenWarrior: Warrior) -> Weapon {  //Return a random weapon from the weapons array of the chosen warrior
        let randomIndex = Int.random(in: 0..<chosenWarrior.weapons.count)
        let randomWeapon = chosenWarrior.weapons[randomIndex]
        return randomWeapon
    }
    
}
