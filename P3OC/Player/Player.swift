//
//  Player.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class Player {
    
// MARK: - INTERNAL
    
// MARK: Properties

    ///To know which player is playing
    let id: Int
    
    ///To know if the player is the looser (when all his warriors are dead)
    var isLooser: Bool {
        !warriors[0].isAlive && !warriors[1].isAlive && !warriors[2].isAlive
    }
    
// MARK: Inits
    
    init(id: Int) {
        self.id = id
    }
    
// MARK:  Methods
    
// MARK: Initialization Phase
    
    ///Create the player's team and describe it
    func createWarriors(allPlayers: [Player]) {
        for warriorIndex in 1...numberOfWarriorPerTeam {
            let allWarriors = getAllWarriors(allPlayers: allPlayers)
            let allWarriorNames = getAllWarriorNames(allWarriors: allWarriors)
            createWarrior(positionInTeam: warriorIndex, allWarriorNames: allWarriorNames)
        }
        describeTeam()
    }
    

// MARK: Fighting Phase
    
    ///Ask which warrior will attack an enemy or heal a teammate
    func fight(opponent: Player) {
        var isActionDone: Bool = false
        
        while isActionDone == false {
            print("\nPlayer \(id) please choose the warrior 🏋️ who will attack 🪓 an ennemy 👿 or heal 💊 a teammate 😎 by entering a number.")
            let chosenWarrior = loopAskToChooseWarrior(from: warriors, canChestAppear: true )
            let actionType = loopAskActionType()
            let target: Warrior
            
            switch actionType {
            case .attack:
                print("\nPlayer \(id) please choose the enemy 👿 who will be attacked 🪓 by entering a number.")
                target = loopAskToChooseWarrior(from: opponent.warriors, canChestAppear: false)
            case .heal:
                print("\nPlayer \(id) please choose the teammate 😎 who will be healed 💊 by entering a number.")
                target = loopAskToChooseWarrior(from: warriors, canChestAppear: false)
            }
            
            isActionDone = action(type: actionType, chosenWarrior: chosenWarrior, target: target)
        }
    }

// MARK: Ending Phase
    
    ///It prints the detailed description of all the player's warriors when the game is over
    func describeTeamEndGame() {
        for warrior in warriors {
            printDetailedDescription(of: warrior)
        }
    }
    
// MARK: - PRIVATE
    
// MARK: Properties
    
    ///There are 3 warriors in each team
    private let numberOfWarriorPerTeam: Int = 3
    
    ///There are 3 types of warrior: magus, knight, archer
    private let numberOfWarriorType: Int = WarriorType.allCases.count
    
    ///Contains warriors of a team
    private var warriors: [Warrior] = []
    
// MARK: Methods
    
// MARK: Initialization phase
    
    ///Return an array containing all the warriors of each player
    private func getAllWarriors(allPlayers: [Player]) -> [Warrior]  {
        var warriors: [Warrior] = []
        
        for player in allPlayers {
            warriors.append(contentsOf: player.warriors)
        }
        return warriors
    }
    
    ///Return an array containing all warriors' name
    private func getAllWarriorNames(allWarriors: [Warrior]) -> [String] {
        allWarriors.map { $0.name }
    }
    
    ///Create 1 warrior with his position in the team, his type and a unique name and fill the array warriors with him
    private func createWarrior(positionInTeam: Int, allWarriorNames: [String]) {
        let warriorType = loopAskWarriorType(positionInTeam: positionInTeam)
        let warriorName = loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        let warrior = createWarriorAccordingToType(type: warriorType, positionInTeam: positionInTeam, warriorName: warriorName)
        warriors.append(warrior)
    }
    
    ///Ask to the player to choose his warrior's type while the 3 guard statements are not satisfied
    private func loopAskWarriorType(positionInTeam: Int) -> WarriorType {
        var warriorType: WarriorType
        
        print("\nPlayer \(id) please choose the type of your warrior 🏋️ N°\(positionInTeam) by entering a number.")
        for (index, warriorType) in WarriorType.allCases.enumerated() {
            printWarriorTypeDescription(type: warriorType, id: index + 1)
        }
        
        guard let warriorTypeOptionalString = readLine() else {
            printWarning(msg: "Please input a number.")
            return loopAskWarriorType(positionInTeam: positionInTeam)
        }
        
        guard let warriorTypeIndex = Int(warriorTypeOptionalString) else {
            printWarning(msg: "The input is invalid. Make sure to enter a number between 1 and \(numberOfWarriorType).")
            return loopAskWarriorType(positionInTeam: positionInTeam)
        }
        
        guard  1...numberOfWarriorType ~= warriorTypeIndex else {
            printWarning(msg: "Please input a valid number between 1 and \(numberOfWarriorType).")
            return loopAskWarriorType(positionInTeam: positionInTeam)
        }
        warriorType = WarriorType.allCases[warriorTypeIndex - 1]
        return warriorType
    }
    
    ///Print all properties of a type of warrior
    private func printWarriorTypeDescription(type: WarriorType, id: Int) {
        
        print("\(id). \(type.extendedDescription) (health points 💚: \(type.maxHp), weapon 🪓: \(type.weapon.description), inflicted damage 💥: \(type.weapon.damage), magic points 💊: \(type.magicPoints))")
    }
    
    ///Ask to enter the warrior's name at a particular position in the team while the 3 verifications are not satisfied
    private func loopAskWarriorName(positionInTeam: Int, allWarriorNames: [String]) -> String {
        var warriorName: String
        print("\nPlayer \(id) please enter the name for your warrior 🏋️ N°\(positionInTeam).")
            
        guard let warriorNameOptionalString = readLine() else {
            printWarning(msg: "The input name of warrior 🏋️ N°\(positionInTeam) is invalid. It is nil. ")
            return loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        }
        
        guard warriorNameOptionalString != "" else {
            printWarning(msg: "The name of warrior 🏋️ N°\(positionInTeam) is empty.")
            return loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
        }
    
        for name in allWarriorNames {
            if name.lowercased() == warriorNameOptionalString.lowercased() {
                printWarning(msg: "This name was already used. Pay attention to uppercase and lowercase.")
                return loopAskWarriorName(positionInTeam: positionInTeam, allWarriorNames: allWarriorNames)
            }
        }
        warriorName = warriorNameOptionalString
        return warriorName
    }
    
    ///Create a warrior according to the chosen type by the player and the warrior's name
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
    
    ///Describe the team of a player with the warrior's position in the team, the warrior's type and the warrior's name
    private func describeTeam() {
        print("\n🎉 Here is the team of player \(id): 🎉")
        for warrior in warriors {
            warrior.describe()
        }
        print("\n")
    }
    

// MARK: Fighting phase
    
    ///While the 3 guard statement are not satisfied it ask to the player to choose a warrior of his team and a chest can probabily appear if canChestAppear == true
    private func loopAskToChooseWarrior(from warriors: [Warrior], canChestAppear: Bool) -> Warrior {
        var chosenWarrior: Warrior
        var selectableNumbers = [Int]()
        
        for warrior in warriors where warrior.isAlive {
            printDetailedDescription(of: warrior)
            selectableNumbers.append(warrior.positionInTeam)
        }
        guard let chosenWarriorOptionalString = readLine() else {
            printWarning(msg: "The input is invalid. Please enter a number.")
            return loopAskToChooseWarrior(from: warriors, canChestAppear: canChestAppear)
        }
        
        guard let chosenWarriorIndex = Int(chosenWarriorOptionalString) else {
            printWarning(msg: "Please enter a number.")
            return loopAskToChooseWarrior(from: warriors, canChestAppear: canChestAppear)
        }
        
        guard selectableNumbers.contains(chosenWarriorIndex) else {
            printWarning(msg: "Make sure to enter one of these numbers \(selectableNumbers).")
            return loopAskToChooseWarrior(from: warriors, canChestAppear: canChestAppear)
        }
        chosenWarrior = warriors[chosenWarriorIndex - 1]
        print("\(printWarrior(chosenWarrior))" + " is selected.")
        
        if canChestAppear == true {
            chosenWarrior.weapon = loopGetRandomWeaponAccordingToChance(for: chosenWarrior)
        }
        return chosenWarrior
    }
    
    ///While the 3 guard statement are not satisfied it ask to the player the type of the action: attack or heal
    private func loopAskActionType() -> ActionType {
        var actionType: ActionType
        
        print("\nPlayer \(id) please choose an action by entering a number."
            + "\n1.🪓 Attack"
            + "\n2.💊 Heal")
        
        guard let actionTypeOptionalString = readLine() else {
            printWarning(msg: "The input is invalid. Make sure to enter 1 or 2.")
            return loopAskActionType()
        }
        
        guard let actionTypeIndex = Int(actionTypeOptionalString) else {
            printWarning(msg: " Please enter a number.")
            return loopAskActionType()
        }
        
        guard 1...2 ~= actionTypeIndex else {
            printWarning(msg: "Please enter 1 or 2.")
            return loopAskActionType()
        }
        
        actionType = ActionType.allCases[actionTypeIndex - 1]
        return actionType
    }
    
    ///Reduce the hp of the target
    private func attack(chosenWarrior: Warrior, target: Warrior) {
        let targetHp = target.hp
        var chosenWarriorWeaponDamage = chosenWarrior.weapon.damage
        if targetHp < chosenWarriorWeaponDamage {
            chosenWarriorWeaponDamage = targetHp
        }
        
        target.hp -= chosenWarrior.weapon.damage
        print("\n😭  " + "\(printWarrior(target))" + " 🪓 (health point 💚: \(targetHp) - \(chosenWarriorWeaponDamage) = \(target.hp)) 😭\n")
        
        if !target.isAlive {
            print("☠️  " + "\(printWarrior(target))" + " is dead. ☠️\n")
        }
    }
    
    ///Increase the hp of the target
    private func heal(chosenWarrior: Warrior, target: Warrior) -> Bool {
        if target.hp == target.maxHp {
            printWarning(msg: "Cannot heal " + "\(printWarrior(target))" + " . His life is full.")
            return false
        } else {
            let targetHp = target.hp
            var chosenWarriorMagicPoints = chosenWarrior.magicPoints
            if targetHp + chosenWarriorMagicPoints > target.maxHp {
                chosenWarriorMagicPoints = target.maxHp - targetHp
            }
            
            target.hp += chosenWarrior.magicPoints
            print("\n🤕  " + "\(printWarrior(target))" + " 💊 (health point 💚: \(targetHp) + \(chosenWarriorMagicPoints) = \(target.hp)) 🤕\n")
            return true
        }
    }
    
    ///The chosen warrior attack an enemy or heal a teammate
    private func action(type: ActionType, chosenWarrior: Warrior, target: Warrior) -> Bool {
        switch type {
        case .attack:
            attack(chosenWarrior: chosenWarrior, target: target)
            return true
        case .heal:
            return heal(chosenWarrior: chosenWarrior, target: target)
        }
    }
    
    ///If chosenWarrior is lucky it returns a random weapon from the array weapons of chosenWarrior while randomWeapon == chosenWarrior.weapon
    private func loopGetRandomWeaponAccordingToChance(for chosenWarrior: Warrior) -> Weapon {
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
