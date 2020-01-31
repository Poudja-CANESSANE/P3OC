//
//  Player.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Player {  //There are 2 players and each player has 1 team
//==================
// MARK: - Properties
//==================
    let id: Int  //To know which player is playing
    
    var warriors: [Warrior] = []  //Contains warriors of a team
    let numberOfWarriorPerTeam = 3  //There are 3 warriors in each team
    var numberOfType = WarriorType.allCases.count  //There are 3 types of warrior: magus, knight, archer
    
    var warriorsNames: [String] {  //Contains warriors' names of a team
        warriors.map { (warrior) -> String in
            warrior.name
        }
    }
    
    init(id: Int) {
        self.id = id
    }
    
//=========================
// MARK: - Internal methods
//=========================
    
    func createWarriors(allWarriorNames: [String]) {  //Create the player's team
        for warriorIndex in 1...numberOfWarriorPerTeam {
            createWarrior(positionInTeam: warriorIndex, allWarriorNames: allWarriorNames)
        }
        describeTeam()
    }
    
    
    func fight(allWarriors: [Warrior]) {  //Ask which warrior will attack an enemy or heal a teammate
        let who = loopAskToChooseWarrior()
        let actionType = loopAskActionType()
        let target = askToChooseTarget(actionType: actionType, allWarriors: allWarriors)
        action(type: actionType, who: who, target: target)
    }
    
//========================
// MARK: - Private methods
//========================
    
//=============================
// MARK: - Initialization phase
//=============================
    
    private func createWarrior(positionInTeam: Int, allWarriorNames: [String]) {  //Create 1 warrior with his position in the team
        let warriorType = loopAskWarriorType(positionInTeam: positionInTeam)
        let warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        let warrior = createWarriorAccordingToType(type: warriorType, positionInTeam: positionInTeam, warriorName: warriorName)
        warriors.append(warrior)
    }
    
    
    private func askWarriorType(positionInTeam: Int) -> WarriorType? {  //Ask to player to choose his warrior's type
        print("Player \(id) please choose the type of your warrior N°\(positionInTeam) by entering a number."
            + "\n1.Magus (weapon damage: 5, heal point: 20)"
            + "\n2.Knight (weapon damage: 20, heal point: 5)"
            + "\n3.Archer (weapon damage: 12, heal point: 12)")
        guard let warriorTypeIndex = readLine() else {
            print("Please input a number.")
            return nil
        }
        
        guard let indexInt = Int(warriorTypeIndex) else {
            print("The input is invalid. Make sure to enter a number between 1 and \(numberOfType).")
            return nil
        }
        
        guard indexInt >= 1 && indexInt <= numberOfType else {
            print("Please input a valid number between 1 and \(numberOfType).")
            return nil
        }
        let warriorType = WarriorType.allCases[indexInt - 1]
        return warriorType
    }
    
    
    private func loopAskWarriorType(positionInTeam: Int) -> WarriorType {  //Ask to choose his warrior's type while it is nil
        var warriorType: WarriorType?
        
        repeat {
            warriorType = askWarriorType(positionInTeam: positionInTeam)
        } while warriorType == nil
        return warriorType!
    }
    
    
    private func askWarriorName(positionInTeam: Int, allWarriorNames: [String]) -> String? {   /* Ask to enter the name of the warrior at a particular position in the team */
        print("Player \(id) please enter the name for your warrior N°\(positionInTeam).")
        guard let warriorName = readLine() else {
            print("The input name of warrior N°\(positionInTeam) is invalid. It is nil.")
            return nil
        }
        
        guard warriorName != "" else {
            print("The name of warrior N°\(positionInTeam) is empty.")
            return nil
        }
        
        let isNameAlreadyTaken = isNameAlreadyTakenBy(allWarriorsNames: allWarriorNames, name: warriorName)
        
        guard !isNameAlreadyTaken else {
            print("One of your warrior already have this name.")
            return nil
        }
        
        return warriorName
    }
    
    private func isNameAlreadyTakenBy(allWarriorsNames: [String], name: String) -> Bool {
        return allWarriorsNames.contains { (warriorName) -> Bool in
            warriorName.lowercased() == name.lowercased()
        }
    }
    

    private func loopAskWarriorName(positionInTeam: Int, allWarriorNames: [String]) -> String {  //Ask the warrior's name while warriorName is nil
        var warriorName: String?
        
        repeat {
            warriorName = askWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        } while warriorName == nil
        return warriorName!
    }
    
    
    private func createWarriorAccordingToType(type: WarriorType, positionInTeam: Int, warriorName: String) -> Warrior {  /*Create a warrior according to the
                                                                                                                           chosen type by the player*/
        switch type {
        case .magus:
            return Magus(positionInTeam: positionInTeam, type: .magus, name: warriorName, weaponDamage: 5, magicPoints: 20)
        case .knight:
            return Knight(positionInTeam: positionInTeam, type: .knight, name: warriorName, weaponDamage: 20, magicPoints: 5)
        case .archer:
            return Archer(positionInTeam: positionInTeam, type: .archer, name: warriorName, weaponDamage: 12, magicPoints: 12)
        }
    }
    
    
    private func describeTeam() {  //Describe the team of a player with the warrior's position in the team and the warrior's name
        print("Here is the team of player \(id):")
        for warrior in warriors {
            warrior.describeWarrior()
        }
        print("\n")
    }
    
//========================
// MARK: - Fighting phase
//========================
    
    func askToChooseWarrior() -> Warrior? {  //Ask to the player to choose a warrior of his team
        print("Player \(id) please choose the warrior who will attack an ennemy or heal a teammate by entering a number.")
        var i = 1
        for warrior in warriors {
            print("\n\(i).\(warrior.name) (type: \(warrior.type), health point: \(warrior.hp), weapon damage: \(warrior.weaponDamage), heal point: \(warrior.magicPoints))")
            i += 1
        }
        guard let chosenWarriorOptionalString = readLine() else {
            print("The input is invalid. Please enter a number between 1 and \(numberOfWarriorPerTeam).")
            return nil
        }
        
        guard let chosenWarriorIndex = Int(chosenWarriorOptionalString) else {
            print("Please enter a number.")
            return nil
        }
        
        guard chosenWarriorIndex >= 1 && chosenWarriorIndex <= numberOfWarriorPerTeam else {
            print("Make sure to enter a number between 1 and \(numberOfWarriorPerTeam).")
            return nil
        }
        
        let chosenWarrior = warriors[chosenWarriorIndex - 1]
        print("\(chosenWarrior.name) is selected.\n")
        return chosenWarrior
    }
    
    
    private func loopAskToChooseWarrior() -> Warrior {  //Ask to choose a warrior of the team while chosenWarrior is nil
        var chosenWarrior: Warrior?
        
        repeat {
            chosenWarrior = askToChooseWarrior()
        } while chosenWarrior == nil
        return chosenWarrior!
    }
    
    
    private func askActionType() -> ActionType? {  //Ask to the player the type of action: attack or heal
        print("Player \(id) please choose an action by entering a number."
            + "\n1.Attack"
            + "\n2.Heal")
        guard let actionTypeOptionalString = readLine() else {
            print("The input is invalid. Make sure to enter 1 or 2.")
            return nil
        }
        
        guard let actionTypeIndex = Int(actionTypeOptionalString) else {
            print("Please enter a number.")
            return nil
        }
        
        guard actionTypeIndex == 1 || actionTypeIndex == 2 else {
            print("Please enter 1 or 2.")
            return nil
        }
        
        let actionType = ActionType.allCases[actionTypeIndex - 1]
        
        return actionType
    }
    
    
    private func loopAskActionType() -> ActionType {  //Ask the action type while actionType is nil
        var actionType: ActionType?
        
        repeat {
            actionType = askActionType()
        } while actionType == nil
        return actionType!
    }
    
    
    private func askToChooseEnemy(allWarriors: [Warrior]) -> Warrior? {  //Ask to choose an enemy
        print("Player \(id) please choose the enemy who will be attacked by entering a number.")
        var enemies: [Warrior] = []
        for warrior in allWarriors where !warriorsNames.contains(warrior.name){
            enemies.append(warrior)
        }
        var i = 1
        for enemy in enemies {
            print("\n\(i).\(enemy.name) (type: \(enemy.type), health point: \(enemy.hp), weapon damage: \(enemy.weaponDamage), heal point: \(enemy.magicPoints))")
            i += 1
        }
        guard let chosenEnemyOptionalString = readLine() else {
            print("The input is invalid. Please enter a number between 1 and \(numberOfWarriorPerTeam).")
            return nil
        }
            
        guard let chosenEnemyIndex = Int(chosenEnemyOptionalString) else {
            print("Please enter a number.")
            return nil
        }
            
        guard chosenEnemyIndex >= 1 && chosenEnemyIndex <= numberOfWarriorPerTeam else {
            print("Make sure to enter a number between 1 and \(numberOfWarriorPerTeam).")
            return nil
        }
        let chosenEnemy = enemies[chosenEnemyIndex - 1]
        return chosenEnemy
    }
    
    
    private func loopAskToChooseEnemy(allWarriors: [Warrior]) -> Warrior {  //Ask to choose an enemy while chosenEnemy is nil
        var chosenEnemy: Warrior?
        
        repeat {
            chosenEnemy = askToChooseEnemy(allWarriors: allWarriors)
        } while chosenEnemy == nil
        return chosenEnemy!
    }
    
    
    private func askToChooseTarget(actionType: ActionType, allWarriors: [Warrior]) -> Warrior {  //Ask to choose a target according to actionType
        switch actionType {
        case .attack:
            return loopAskToChooseEnemy(allWarriors: allWarriors)
        case .heal:
            return loopAskToChooseWarrior()
        }
    }
    
    
    private func attack(who: Warrior,target: Warrior) {  //Reduce the hp of the target
        target.hp -= who.weaponDamage
    }
    
    
    private func heal(who: Warrior, target: Warrior) {  //Increase the hp of the target
        target.hp += who.magicPoints
    }
    
    
    private func action(type: ActionType, who: Warrior, target: Warrior) {  //The chosen warrior attack an enemy or heal a teammate
        switch type {
        case .attack:
            attack(who: who, target: target)
        case .heal:
            heal(who: who, target: target)
        }
    }
}
