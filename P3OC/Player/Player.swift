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
    
    let numberOfWarriorPerTeam: Int = 3  //There are 3 warriors in each team
    let numberOfWarriorType: Int = WarriorType.allCases.count  //There are 3 types of warrior: magus, knight, archer

    let id: Int  //To know which player is playing
    var warriors: [Warrior] = []  //Contains warriors of a team
    
    var isLooser: Bool {  //To know if the player is the looser (when all his warriors are dead)
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
    
    func createWarriors(allPlayers: [Player]) {  //Create the player's team and describe it
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
            guard let who = loopAskToChooseWarrior(from: warriors, canChestAppear: true ) else { return }
            guard let actionType = loopAskActionType() else { return }
            let target: Warrior?
            
            switch actionType {
            case .attack:
                print("\nPlayer \(id) please choose the enemy 👿 who will be attacked 🪓 by entering a number.")
                target = loopAskToChooseWarrior(from: opponent.warriors, canChestAppear: false)
            case .heal:
                print("\nPlayer \(id) please choose the teammate 😎 who will be healed 💊 by entering a number.")
                target = loopAskToChooseWarrior(from: warriors, canChestAppear: false)
            }
            
            isActionDone = action(type: actionType, who: who, target: target)
        }
    }

//=====================
// MARK: - Ending Phase
//=====================

    func describeTeamEndGame() {  //It prints the detailed description of all the player's warriors when the game is                               over
        for warrior in warriors {
            printDetailedDescription(of: warrior)
        }
    }
    
//==========================
// MARK: - METHODS - PRIVATE
//==========================
    
//=============================
// MARK: - Initialization phase
//=============================
    
    private func getAllWarriors(allPlayers: [Player]) -> [Warrior]  {  //Return an array containing all the warriors                                                                    of each player
        var warriors: [Warrior] = []
        
        for player in allPlayers {
            warriors.append(contentsOf: player.warriors)
        }
        return warriors
    }
    
    
    private func getAllWarriorNames(allWarriors: [Warrior]) -> [String] {  //Return an array containing all warriors'                                                                       name
        allWarriors.map { $0.name }
    }
    
    
    private func createWarrior(positionInTeam: Int, allWarriorNames: [String]) {  //Create 1 warrior with his positin in the team, his type and a unique name and fill the array warriors with him
        guard let warriorType = loopAskWarriorType(positionInTeam: positionInTeam) else { return }
        guard let warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames) else { return }
        let warrior = createWarriorAccordingToType(type: warriorType, positionInTeam: positionInTeam, warriorName: warriorName)
        warriors.append(warrior)
    }
    
    
    private func loopAskWarriorType(positionInTeam: Int) -> WarriorType? {  //Ask to the player to choose his                                                                                warrior's type while warriorType is nil
        var warriorType: WarriorType?
        print("\nPlayer \(id) please choose the type of your warrior 🏋️ N°\(positionInTeam) by entering a number."
            + "\n1.🎩 Magus (weapon 🪓: \(Weapon.stone.description), inflicted damage 💥: \(Weapon.stone.damage), magic points 💊: 30)"
            + "\n2.⚔️ Knight (weapon 🪓: \(Weapon.sword.description), inflicted damage 💥: \(Weapon.sword.damage), magic points 💊: 10)"
            + "\n3.🏹 Archer (weapon 🪓: \(Weapon.bow.description), inflicted damage 💥: \(Weapon.bow.damage), magic points 💊: 20)")
        
        guard let warriorTypeOptionalString = readLine() else {
            printWarning(msg: "Please input a number.")
            warriorType = loopAskWarriorType(positionInTeam: positionInTeam)
            return warriorType
        }
        
        guard let warriorTypeIndex = Int(warriorTypeOptionalString) else {
            printWarning(msg: "The input is invalid. Make sure to enter a number between 1 and \(numberOfWarriorType).")
            warriorType = loopAskWarriorType(positionInTeam: positionInTeam)
            return warriorType
        }
        
        guard warriorTypeIndex >= 1 && warriorTypeIndex <= numberOfWarriorType else {
            printWarning(msg: "Please input a valid number between 1 and \(numberOfWarriorType).")
            warriorType = loopAskWarriorType(positionInTeam: positionInTeam)
            return warriorType
        }
        warriorType = WarriorType.allCases[warriorTypeIndex - 1]
        return warriorType
    }
    

    private func loopAskWarriorName(positionInTeam: Int, allWarriorNames: [String]) -> String? {  //Ask to enter the warrior's name at a particular position in the team while warriorName is nil
        var warriorName: String?
        print("\nPlayer \(id) please enter the name for your warrior 🏋️ N°\(positionInTeam).")
            
        guard let warriorNameOptionalString = readLine() else {
            printWarning(msg: "The input name of warrior 🏋️ N°\(positionInTeam) is invalid. It is nil. ")
            warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
            return warriorName
        }
        
        guard warriorNameOptionalString != "" else {
            printWarning(msg: "The name of warrior 🏋️ N°\(positionInTeam) is empty.")
            warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
            return warriorName
        }
    
        for name in allWarriorNames {
            if name.lowercased() == warriorNameOptionalString.lowercased() {
                printWarning(msg: "This name was already used. Pay attention to uppercase and lowercase.")
                warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
                return warriorName
            }
        }
        warriorName = warriorNameOptionalString
        return warriorName
    }
    
    
    private func createWarriorAccordingToType(type: WarriorType, positionInTeam: Int, warriorName: String) -> Warrior {  //Create a warrior according to the chosen type by the player and the warrior's name
        switch type {
        case .magus:
            return Magus(positionInTeam: positionInTeam, type: .magus, name: warriorName)
        case .knight:
            return Knight(positionInTeam: positionInTeam, type: .knight, name: warriorName)
        case .archer:
            return Archer(positionInTeam: positionInTeam, type: .archer, name: warriorName)
        }
    }
    
    
    private func describeTeam() {  //Describe the team of a player with the warrior's position in the team, the                                     warrior's type and the warrior's name
        print("\n🎉 Here is the team of player \(id): 🎉")
        for warrior in warriors {
            warrior.describe()
        }
        print("\n")
    }
    
//=======================
// MARK: - Fighting phase
//=======================
    
    private func loopAskToChooseWarrior(from warriors: [Warrior], canChestAppear: Bool) -> Warrior? {  //While chosenWarrior is nil it ask to the player to choose a warrior of his team and a chest can probabily appear if canChestAppear == true
        var chosenWarrior: Warrior?
        
        var selectableNumbers: [Int] = []
        for warrior in warriors where warrior.isAlive {
            printDetailedDescription(of: warrior)
            selectableNumbers.append(warrior.positionInTeam)
        }
        guard let chosenWarriorOptionalString = readLine() else {
            printWarning(msg: "The input is invalid. Please enter a number.")
            chosenWarrior = loopAskToChooseWarrior(from: warriors, canChestAppear: canChestAppear)
            return chosenWarrior
        }
        
        guard let chosenWarriorIndex = Int(chosenWarriorOptionalString) else {
            printWarning(msg: "Please enter a number.")
            chosenWarrior = loopAskToChooseWarrior(from: warriors, canChestAppear: canChestAppear)
            return chosenWarrior
        }
        
        guard selectableNumbers.contains(chosenWarriorIndex) else {
            printWarning(msg: "Make sure to enter one of these numbers \(selectableNumbers).")
            chosenWarrior = loopAskToChooseWarrior(from: warriors, canChestAppear: canChestAppear)
            return chosenWarrior
        }
        chosenWarrior = warriors[chosenWarriorIndex - 1]
        print("\(printWarrior(chosenWarrior))" + " is selected.")
        
        if canChestAppear == true {
            guard let warrior = chosenWarrior else { return nil }
            warrior.weapon = loopGetRandomWeaponAccordingToChance(for: warrior)
        }
        return chosenWarrior
    }
    
    
    private func loopAskActionType() -> ActionType? {  //Ask the action type while actionType is nil
        var actionType: ActionType?
        
        print("\nPlayer \(id) please choose an action by entering a number."
                + "\n1.🪓 Attack"
                + "\n2.💊 Heal")
        
        guard let actionTypeOptionalString = readLine() else {
            printWarning(msg: "The input is invalid. Make sure to enter 1 or 2.")
            actionType = loopAskActionType()
            return actionType
        }
        
        guard let actionTypeIndex = Int(actionTypeOptionalString) else {
            printWarning(msg: " Please enter a number.")
            actionType = loopAskActionType()
            return actionType
        }
        
        guard actionTypeIndex == 1 || actionTypeIndex == 2 else {
            printWarning(msg: "Please enter 1 or 2.")
            actionType = loopAskActionType()
            return actionType
        }
        
        actionType = ActionType.allCases[actionTypeIndex - 1]
        return actionType
    }
    
    
    private func attack(who: Warrior, target: Warrior?) {  //Reduce the hp of the target
        guard let target = target else { return }
        let targetHp = target.hp
        var whoWeaponDamage = who.weapon.damage
        if targetHp < whoWeaponDamage {
            whoWeaponDamage = targetHp
        }
        target.hp -= who.weapon.damage
        print("\n😭  " + "\(printWarrior(target))" + " 🪓 (health point 💚: \(targetHp) - \(whoWeaponDamage) = \(target.hp)) 😭\n")
        if !target.isAlive {
            print("☠️  " + "\(printWarrior(target))" + " is dead. ☠️\n")
        }
    }
    
    
    private func heal(who: Warrior, target: Warrior?) -> Bool {  //Increase the hp of the target
        guard let target = target else { return false }
        if target.hp == target.maxHp {
            printWarning(msg: "Cannot heal " + "\(printWarrior(target))" + " . His life is full.")
            return false
        } else {
            let targetHp = target.hp
            var whoMagicPoints = who.magicPoints
            if targetHp + whoMagicPoints > target.maxHp {
                whoMagicPoints = target.maxHp - targetHp
            }
            target.hp += who.magicPoints
            print("\n🤕  " + "\(printWarrior(target))" + " 💊 (health point 💚: \(targetHp) + \(whoMagicPoints) = \(target.hp)) 🤕\n")
            return true
        }
    }
    
    
    private func action(type: ActionType, who: Warrior, target: Warrior?) -> Bool {  //The chosen warrior attack an enemy or heal a teammate
        switch type {
        case .attack:
            attack(who: who, target: target)
            return true
        case .heal:
            return heal(who: who, target: target)
        }
    }
    
    
    private func loopGetRandomWeaponAccordingToChance(for chosenWarrior: Warrior) -> Weapon {  //If chosenWarrior is lucky it returns a random weapon from the array weapons of chosenWarrior while randomWeapon == chosenWarrior.weapon
        let hasChance = Int.random(in: 1...3) == 1
        
        if  hasChance {
            var randomWeapon = chosenWarrior.weapon

            while randomWeapon == chosenWarrior.weapon {
                randomWeapon = chosenWarrior.weapons.randomElement() ?? chosenWarrior.weapon
            }
            print("\n🎊🍀  " + "\(printWarrior(chosenWarrior))" + " is lucky ! A chest appeared at his feet. 🍀🎊"
                + "\nThere is a \(randomWeapon.description) in it (inflicted damage 💥: \(randomWeapon.damage))\n")
            return randomWeapon
        } else {
            return chosenWarrior.weapon
        }
    }
}
