//
//  Player.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Player {  //There are 2 players and each player has 1 team
//===================
// MARK: - Properties
//===================
    
    let numberOfWarriorPerTeam = 3  //There are 3 warriors in each team
    var numberOfWarriorType = WarriorType.allCases.count  //There are 3 types of warrior: magus, knight, archer

    let id: Int  //To know which player is playing
    var warriors: [Warrior] = []  //Contains warriors of a team
    
    var isLooser: Bool {
        !warriors[0].isAlive && !warriors[1].isAlive && !warriors[2].isAlive
    }
    
//==============
// MARK: - Inits
//==============
    
    init(id: Int) {
        self.id = id
    }
    
//===========================
// MARK: - METHODS - INTERNAL
//===========================
    
//=============================
// MARK: - Initialization Phase
//=============================
    
    func createWarriors(allPlayers: [Player]) {  //Create the player's team
        for warriorIndex in 1...numberOfWarriorPerTeam {
            let allWarriors = getAllWarriors(allPlayers: allPlayers)
            let allWarriorNames = getAllWarriorNames(allWarriors: allWarriors)
            createWarrior(positionInTeam: warriorIndex, allWarriorNames: allWarriorNames)
        }
        describeTeam()
    }
    

//=======================
// MARK: - Fighting Phase
//=======================
    
    func fight(opponent: Player) {  //Ask which warrior will attack an enemy or heal a teammate
        var isActionDone: Bool = false
        
        while isActionDone == false {
            print("\nPlayer \(id) please choose the warrior 🏋️ who will attack 🪓 an ennemy 👿 or heal 💊 a teammate 😎 by entering a number.")
            let who = loopAskToChooseWarrior(from: self.warriors)
            let actionType = loopAskActionType()
            let target: Warrior
            
            switch actionType {
            case .attack:
                print("\nPlayer \(id) please choose the enemy 👿 who will be attacked 🪓 by entering a number.")
                target = loopAskToChooseWarrior(from: opponent.warriors)
            case .heal:
                print("\nPlayer \(id) please choose the teammate 😎 who will be healed 💊 by entering a number.")
                target = loopAskToChooseWarrior(from: self.warriors)
            }
            
            isActionDone = action(type: actionType, who: who, target: target)
        }
    }

//=====================
// MARK: - Ending Phase
//=====================

    func describeTeamEndGame() {
        for warrior in warriors {
            print("\(warrior.positionInTeam).\(warrior.name) (type: \(warrior.type.description) \(warrior.type), health point 💚: \(warrior.hp), weapon damage 🪓: \(warrior.weaponDamage), heal point 💊: \(warrior.magicPoints))")
        }
    }
    
//==========================
// MARK: - METHODS - PRIVATE
//==========================
    
//=============================
// MARK: - Initialization phase
//=============================
    
    private func getAllWarriors(allPlayers: [Player]) -> [Warrior]  {  //Contains players' team
        var warriors: [Warrior] = []
        
        for player in allPlayers {
            warriors.append(contentsOf: player.warriors)
        }
        return warriors
    }
    
    
    private func getAllWarriorNames(allWarriors: [Warrior]) -> [String] {  //Contains all warrior's names
        allWarriors.map { $0.name }
    }
    
    
    private func createWarrior(positionInTeam: Int, allWarriorNames: [String]) {  //Create 1 warrior with his position in the team
        let warriorType = loopAskWarriorType(positionInTeam: positionInTeam)
        let warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        let warrior = createWarriorAccordingToType(type: warriorType, positionInTeam: positionInTeam, warriorName: warriorName)
        warriors.append(warrior)
    }
    
    
    private func askWarriorType(positionInTeam: Int) -> WarriorType? {  //Ask to player to choose his warrior's type
        print("\nPlayer \(id) please choose the type of your warrior 🏋️ N°\(positionInTeam) by entering a number."
            + "\n1.🎩 Magus (weapon damage: \(Weapon.stone.damage), heal point: 30)"
            + "\n2.⚔️ Knight (weapon damage: \(Weapon.sword.damage), heal point: 10)"
            + "\n3.🏹 Archer (weapon damage: \(Weapon.bow.damage), heal point: 20)")
        
        guard let warriorTypeOptionalString = readLine() else {
            printWarning(msg: "Please input a number.")
            return nil
        }
        
        guard let warriorTypeIndex = Int(warriorTypeOptionalString) else {
            printWarning(msg: "The input is invalid. Make sure to enter a number between 1 and \(numberOfWarriorType).")
            return nil
        }
        
        guard warriorTypeIndex >= 1 && warriorTypeIndex <= numberOfWarriorType else {
            printWarning(msg: "Please input a valid number between 1 and \(numberOfWarriorType).")
            return nil
        }
        let warriorType = WarriorType.allCases[warriorTypeIndex - 1]
        return warriorType
    }
    
    
    private func loopAskWarriorType(positionInTeam: Int) -> WarriorType {  //Ask to choose his warrior's type while it is nil
        var warriorType: WarriorType?
        
        while warriorType == nil {
            warriorType = askWarriorType(positionInTeam: positionInTeam)
        }
        return warriorType!
    }
    
    
    private func askWarriorName(positionInTeam: Int, allWarriorNames: [String]) -> String? {   /* Ask to enter the name of the warrior at a particular position in the team */
        print("\nPlayer \(id) please enter the name for your warrior 🏋️ N°\(positionInTeam).")
        guard let warriorName = readLine() else {
            printWarning(msg: "The input name of warrior 🏋️ N°\(positionInTeam) is invalid. It is nil. ")
            return nil
        }
        
        guard warriorName != "" else {
            printWarning(msg: "The name of warrior 🏋️ N°\(positionInTeam) is empty.")
            return nil
        }
    
        for name in allWarriorNames {
            if name.lowercased() == warriorName.lowercased() {
                printWarning(msg: "This name was already used. Pay attention to uppercase and lowercase.")
                return nil
            }
        }
        return warriorName
    }
    

    private func loopAskWarriorName(positionInTeam: Int, allWarriorNames: [String]) -> String {  //Ask the warrior's name while warriorName is nil
        var warriorName: String?
        
        while warriorName == nil {
            warriorName = askWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        }
        return warriorName!
    }
    
    
    private func createWarriorAccordingToType(type: WarriorType, positionInTeam: Int, warriorName: String) -> Warrior {  //Create a warrior according to the chosen type by the player
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
        print("\n🎉 Here is the team of player \(id): 🎉")
        for warrior in warriors {
            warrior.describe()
        }
        print("\n")
    }
    
//========================
// MARK: - Fighting phase
//========================
    
    private func askToChooseWarrior(from warriors: [Warrior]) -> Warrior? {  //Ask to the player to choose a warrior of his team
        var selectableNumbers: [Int] = []
        for warrior in warriors where warrior.isAlive {
            print("\(warrior.positionInTeam).\(warrior.name) (type: \(warrior.type.description) \(warrior.type), health point 💚: \(warrior.hp), weapon damage 🪓: \(warrior.weaponDamage), heal point 💊: \(warrior.magicPoints))")
            selectableNumbers.append(warrior.positionInTeam)
        }
        guard let chosenWarriorOptionalString = readLine() else {
            printWarning(msg: "The input is invalid. Please enter a number.")
            return nil
        }
        
        guard let chosenWarriorIndex = Int(chosenWarriorOptionalString) else {
            printWarning(msg: "Please enter a number.")
            return nil
        }
        
        guard selectableNumbers.contains(chosenWarriorIndex) else {
            printWarning(msg: "Make sure to enter one of these numbers \(selectableNumbers).")
            return nil
        }
        let chosenWarrior = warriors[chosenWarriorIndex - 1]
        print("\(chosenWarrior.type.description) \(chosenWarrior.name) is selected.")
        return chosenWarrior
    }
    
    
    private func loopAskToChooseWarrior(from warriors: [Warrior]) -> Warrior {  //Ask to choose a warrior of the team while chosenWarrior is nil
        var chosenWarrior: Warrior?
        
        while chosenWarrior == nil {
            chosenWarrior = askToChooseWarrior(from: warriors)
        }
        return chosenWarrior!
    }
    
    
    private func askActionType() -> ActionType? {  //Ask to the player the type of action: attack or heal
        print("\nPlayer \(id) please choose an action by entering a number."
            + "\n1.🪓 Attack"
            + "\n2.💊 Heal")
        
        guard let actionTypeOptionalString = readLine() else {
            printWarning(msg: "The input is invalid. Make sure to enter 1 or 2.")
            return nil
        }
        
        guard let actionTypeIndex = Int(actionTypeOptionalString) else {
            printWarning(msg: " Please enter a number.")
            return nil
        }
        
        guard actionTypeIndex == 1 || actionTypeIndex == 2 else {
            printWarning(msg: "Please enter 1 or 2.")
            return nil
        }
        
        let actionType = ActionType.allCases[actionTypeIndex - 1]
        return actionType
    }
    
    
    private func loopAskActionType() -> ActionType {  //Ask the action type while actionType is nil
        var actionType: ActionType?
        
        while actionType == nil {
            actionType = askActionType()
        }
        return actionType!
    }
    
    
    private func attack(who: Warrior, target: Warrior) {  //Reduce the hp of the target
        let targetHp = target.hp
        var whoWeaponDamage = who.weaponDamage
        if targetHp - whoWeaponDamage < 0 {
            whoWeaponDamage = targetHp
        }
        target.hp -= who.weaponDamage
        print("😭  \(target.type.description) \(target.name) 🪓 (health point 💚: \(targetHp) - \(whoWeaponDamage) = \(target.hp)) 😭\n")
        if !target.isAlive {
            print("☠️ \(target.type.description) \(target.name) is dead. ☠️\n")
        }
    }
    
    
    private func heal(who: Warrior, target: Warrior) -> Bool {  //Increase the hp of the target
        if target.hp == target.maxHp {
            printWarning(msg: "Cannot heal \(target.type.description) \(target.name). His life is full.")
            print("\n")
            return false
        } else {
            let targetHp: Int = target.hp
            var whoMagicPoints = who.magicPoints
            if targetHp + whoMagicPoints > target.maxHp {
                whoMagicPoints = target.maxHp - targetHp
            }
            target.hp += who.magicPoints
            print("🤕  \(target.type.description) \(target.name) 💊 (health point 💚: \(targetHp) + \(whoMagicPoints) = \(target.hp)) 🤕\n")
            return true
        }
    }
    
    
    private func action(type: ActionType, who: Warrior, target: Warrior) -> Bool {  //The chosen warrior attack an enemy or heal a teammate
        switch type {
        case .attack:
            attack(who: who, target: target)
            return true
        case .heal:
            return heal(who: who, target: target)
        }
    }
}
