//
//  GameManager.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class GameManager {
//===================
// MARK: - Properties
//===================
    let numberOfPlayer = 2  //There are 2 players
    private var players: [Player] = []  //Contains players of the game
    
    private var allWarriors: [Warrior] {  //Contains players' team
        var warriors: [Warrior] = []
        
        for player in players {
            warriors.append(contentsOf: player.warriors)
        }
        return warriors
    }
    
    static var allWarriorNames: [String] = [] //Contains all warrior's names
    
    var numberOfRound: Int = 0  //This is the number of round
    var wantToRestart: Bool? = false
    
//========================
// MARK: - Internal method
//========================
    
    func startGame() {  //Manage each phase of the game
        createPlayers()
        startTeamCreationPhase()
        startFightingPhase()
        handleEndGame()
    }
    
//========================
// MARK: - Private methods
//========================
    
    private func createPlayers() {  //Initialization phase, create 2 players
        for playerId in 1...numberOfPlayer {
            let player = Player(id: playerId)
            players.append(player)
        }
    }
    
    private func startTeamCreationPhase() {  //Initialization phase, create a team for each players
        for player in players {
            wantToRestart = player.createWarriors(wantToRestart: wantToRestart!)
        }
    }
    
    private func startFightingPhase() {  //Fighting phase
        while !(players[0].isLooser || players[1].isLooser) {
            for player in players {
                if !(players[0].isLooser || players[1].isLooser) {
                    player.fight(allWarriors: allWarriors)
                    numberOfRound += 1
                }
            }
        }
    }
    
    
    private func handleEndGame() {  //Ending phase: print winner, number of round, print players' team
        print("\n                              *****END*****")
        if players[0].isLooser {
            print("\n🎉🥇 Player 2 is the WINNER !!! 🥇🎉")
        } else if players[1].isLooser {
            print("\n🎉🥇 Player 1 is the WINNER !!! 🥇🎉")
        }
        print("\n                           *****STATISTICS*****")
        print("\nNumber of round: \(numberOfRound)")
        for player in players {
            print("\nHere is the team of player \(player.id):")
            player.describeTeamEndGame()
        }
        print("\n")
        wantToRestart = loopAskToRestartGame()
        if wantToRestart == true {
            startGame()
        }
    }
    
    
    private func askToRestartGame() -> Bool? {
        print("\nDo you want to play again ?"
            + "\n1. YES"
            + "\n2. NO")
        
        guard let restartOptionalString = readLine() else {
            print("⚠️ The input is invalid. ⚠️")
            return nil
        }
        
        guard let restartIndex = Int(restartOptionalString) else {
            print("⚠️ Please enter a number. ⚠️")
            return nil
        }
        
        guard restartIndex == 1 || restartIndex == 2 else {
            print("⚠️ Make sure to enter 1 or 2. ⚠️")
            return nil
        }
        
        if restartIndex == 1 {
            wantToRestart = true
            players = []
            startGame()
        } else if restartIndex == 2 {
            wantToRestart = false
        }
        return wantToRestart
    }
    
    
    private func loopAskToRestartGame() -> Bool {
        wantToRestart = nil
        while wantToRestart == nil  {
            wantToRestart = askToRestartGame()
        }
        return wantToRestart!
    }
}
