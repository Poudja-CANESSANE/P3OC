//
//  Warrior.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Warrior {
    
    let positionInTeam: Int  //To know which warrior is selected
    var type: WarriorType  //This is the warrior's type
    let name: String  //This is the warrior's name
    
    init(positionInTeam: Int, type: WarriorType, name: String) {
        self.positionInTeam = positionInTeam
        self.type = type
        self.name = name
    }
    
    func describeWarrior() {  //Describe the warrior with his position in the team and his name
        print("Your warrior N°\(positionInTeam) is a \(type) and his name is \(name).")
    }
}
