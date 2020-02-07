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
    
    func loopMakeAppearChestWithRandomWeapon(chosenWarrior: Warrior, actualWeapon: Weapon) ->Weapon {
        var randomWeapon: Weapon = actualWeapon
        
        while randomWeapon == actualWeapon {
            randomWeapon = makeAppearChestWithRamdomWeapon(chosenWarrior: chosenWarrior)
        }
        return randomWeapon
    }
    
//==========================
// MARK: - METHODS - PRIVATE
//==========================
    
    private func makeAppearChestWithRamdomWeapon(chosenWarrior: Warrior) -> Weapon {
        let randomIndex: Int = Int(arc4random_uniform(UInt32(chosenWarrior.weapons.count)))
        let randomWeapon = chosenWarrior.weapons[randomIndex]
        return randomWeapon
    }
    
}
