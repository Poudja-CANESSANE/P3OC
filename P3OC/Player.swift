//
//  Player.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Player {  //There are 2 players and each player has 1 team
    let id: Int  //To know which player is playing
    
    var warriors: [Warrior] = []  //Contains warriors of a team
    let numberOfWarriorPerTeam = 3  //There are 3 warriors in each team
    var numberOfType = WarriorType.allCases.count
    
    var warriorsNames: [String] {
        warriors.map { (warrior) -> String in
            warrior.name
        }
    }  //Contains warriors' names of a team
    
    init(id: Int) {
        self.id = id
    }
    
    func createWarriors(allWarriorNames: [String]) {  //Create the player's team
        for warriorIndex in 1...numberOfWarriorPerTeam {
            createWarrior(positionInTeam: warriorIndex, allWarriorNames: allWarriorNames)
        }
        describeTeam()
    }
    
    private func createWarrior(positionInTeam: Int, allWarriorNames: [String]) {  //Create 1 warrior with his position in the team
        
        let warriorType = loopAskWarriorType(id: id, positionInTeam: positionInTeam)
        
        let warriorName = loopAskWarriorName(id: id, positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)

        let warrior = createWarriorAccordingToType(type: warriorType, positionInTeam: positionInTeam, warriorName: warriorName)
        warriors.append(warrior)

    }
    
    
    private func askWarriorType(id: Int, positionInTeam: Int) -> WarriorType? {
        print("Player \(id) please choose the type of your warrior N°\(positionInTeam) by entering a number."
            + "\n1.Magus"
            + "\n2.Knight"
            + "\n3.Archer")
        guard let warriorTypeIndex = readLine() else {
            print("Please input a number.")
            return nil
        }
        
        guard let indexInt = Int(warriorTypeIndex) else {
            print("The input number is invalid. Make sure to enter a number between 1 and \(numberOfType).")
            return nil
        }
        
        guard indexInt >= 1 && indexInt <= numberOfType else {
            print("Please input a valid number between 1 and \(numberOfType).")
            return nil
        }
        
        let warriorType = WarriorType.allCases[indexInt - 1]
        
        return warriorType
    }
    
    
    private func loopAskWarriorType(id: Int, positionInTeam: Int) -> WarriorType {
        var warriorType: WarriorType?
        
        repeat {
            warriorType = askWarriorType(id: id, positionInTeam: positionInTeam)
        } while warriorType == nil
        return warriorType!
    }
    
    
    private func askWarriorName(id: Int, positionInTeam: Int, allWarriorNames: [String]) -> String? {   /* Ask to the user to enter the name                                                                                                             of his warrior at a particular position in the team */
        print("Player \(id) please enter the name for your warrior N°\(positionInTeam).")
        guard let warriorName = readLine() else {
            print("The input name of warrior N°\(positionInTeam) is invalid. It is nil.")
            return nil
        }
        
        guard warriorName != "" else {
            print("The name of warrior N°\(positionInTeam) is empty.")
            return nil
        }
        
        guard !warriorsNames.contains(warriorName) else {
            print("You already used this name")
            return nil
        }
        
        guard !allWarriorNames.contains(warriorName) else {
            print("This name already exists.")
            return nil
        }
        return warriorName
    }
    

    private func loopAskWarriorName(id: Int, positionInTeam: Int, allWarriorNames: [String]) -> String {  //Ask the name of each warrior per player
        var warriorName: String?
        
        repeat {
            warriorName = askWarriorName(id: id, positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        } while warriorName == nil
        return warriorName!
    }
    
    
    private func createWarriorAccordingToType(type: WarriorType, positionInTeam: Int, warriorName: String) -> Warrior {
        switch type {
        case .magus:
            return Magus(positionInTeam: positionInTeam, type: .magus, name: warriorName)
        case .knight:
            return Knight(positionInTeam: positionInTeam, type: .knight, name: warriorName)
        case .archer:
            return Archer(positionInTeam: positionInTeam, type: .archer, name: warriorName)
        }
    }
    
    
    private func describeTeam() {  //Describe the team of a player with the warrior's position in the team and the warrior's name
        print("Here is the team of player \(id):")
        for warrior in warriors {
            warrior.describeWarrior()
        }
        print("\n")
    }
}
