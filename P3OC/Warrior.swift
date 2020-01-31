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
//    var type: String
    let name: String  //This is the warrior's name
    
    init(positionInTeam: Int, name: String) {
        self.positionInTeam = positionInTeam
//        self.type = type
        self.name = name
    }

//        switch type {
//        case "magus":
//            Magus(magusPositionInTeam: positionInTeam, magusName: name)
//        case "knight":
//            Knight(knightPositionInTeam: positionInTeam, knightName: name)
//        case "archer":
//            Archer(archerPositionInTeam: positionInTeam, archerName: name)
//        default:
//            print("Error type")
//        }
//    }
    
    func describeWarrior() {  //Describe the warrior with his position in the team and his name
        print("Your warrior N°\(positionInTeam) name is \(name).")
    }
}
