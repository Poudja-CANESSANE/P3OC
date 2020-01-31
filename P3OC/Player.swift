//
//  Player.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

public class Player {  //There are 2 players and each player has 1 team
    let id: Int  //To know which player is playing
    
    var warriors: [Warrior] = []  //Contains warriors of a team
    let numberOfWarriorPerTeam = 3  //There are 3 warriors in each team
    var warriorsNames: [String] = []  //Contains warriors' names of a team
    
    init(id: Int) {
        self.id = id
    }

    func createWarriors() {  //Create a team for each players
        for warriorIndex in 1...numberOfWarriorPerTeam {
            createWarrior(positionInTeam: warriorIndex)
        }
        describeTeam()
    }

    private func createWarrior(positionInTeam: Int) {  //Create 1 warrior with his position in the team
        
//        guard let warriorType = askWarriorType(positionInTeam: positionInTeam) else {
//            print("Your warrior type is empty")
//            return
//        }
        let warriorName = loopAskWarriorName(id: id)

        let warrior = Warrior(positionInTeam: positionInTeam, name: warriorName)
        warriors.append(warrior)


    }

//    private func askWarriorType(positionInTeam: Int) -> String? {
//        print("Player \(id) please enter the type of your warrior N°\(positionInTeam).")
//        guard let warriorType = readLine() else {
//            print("The input type is invalid. Make sure to write exactly how the type is printed.")
//            return nil
//        }
//        return warriorType
//    }
    
    private func askWarriorName(positionInTeam: Int) -> String? {   /* Ask to the user to enter the name                                                                                                             of his warrior at a particular position in the team */
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
            print("This name already exists.")
            return nil
        }
        warriorsNames.append(warriorName)
        return warriorName
    }

    private func describeTeam() {  //Describe the team of a player with the warrior's position in the team and the warrior's name
        print("Here is the team of player \(id):")
        for warrior in warriors {
            warrior.describeWarrior()
        }
    }

    func loopAskWarriorName(id: Int) -> String {  //Ask the name of each warrior per player
        var warriorName = ""
        for _ in 1...2 {
            for warriorNameIndex in 1...numberOfWarriorPerTeam {
                guard let warriorNameOptional = askWarriorName(positionInTeam: warriorNameIndex) else { return loopAskWarriorName(id: id) }
                warriorName = warriorNameOptional
            }

        }
        return warriorName
    }

}
