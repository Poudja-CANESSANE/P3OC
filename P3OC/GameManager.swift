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
    
    public var players: [Player] = []  //Contains players of the game
        
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
        for player in players {
            player.createWarriors()
        }
    }

    private func startFightingPhase() {  //Fighting phase
            
    }

    private func handleEndGame() {  //Ending phase
        
    }
}
