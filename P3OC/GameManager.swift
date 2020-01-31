//
//  GameManager.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class GameManager {
    let numberOfPlayer = 2  //There are 2 players
    private var players: [Player] = []  //Contains players of the game
    
    private var allWarriorNames: [String] { //Contains all warrior's names
        var names: [String] = []
        
        for player in players {
            names.append(contentsOf: player.warriorsNames)
        }
        return names
    }
    
    func startGame() {  //Manage each phase of the game
        createPlayers()
        startTeamCreationPhase()
        startFightingPhase()
        handleEndGame()
    }
    
    private func createPlayers() {  //Initialization phase
        for playerId in 1...numberOfPlayer {
            let player = Player(id: playerId)
            players.append(player)
        }
    }
    
    private func startTeamCreationPhase() {  //Initialization phase
        //Create a team for each players
        for player in players {
            player.createWarriors(allWarriorNames: allWarriorNames)
        }
    }
    
    private func startFightingPhase() {  //Fighting phase
        
    }
    
    private func handleEndGame() {  //Ending phase
        
    }
}
