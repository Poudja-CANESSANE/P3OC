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
            player.createWarriors()
        }
    }
    
    private func startFightingPhase() {  //Fighting phase
        while !(players[0].isLooser || players[1].isLooser) {
            for player in players {
                if !(players[0].isLooser || players[1].isLooser) {
                    player.fight(allWarriors: allWarriors)
                    numberOfRound += 1
                } else {
                    return
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
    }
}
