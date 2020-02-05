//
//  Health.swift
//  P3OC
//
//  Created by Canessane Poudja on 04/02/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Health {
    
    let maxHp: Int = 100
    
    var hp: Int = 100 {  //This is the warrior's life
        didSet {
            if hp > maxHp {
                hp = maxHp
            } else if !isAlive {
                hp = 0
            }
        }
    }
        
    var isAlive: Bool {
        return hp > 0
    }
}
