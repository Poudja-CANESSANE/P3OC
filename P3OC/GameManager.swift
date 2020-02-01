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
    
    var warriors1: [Warrior] {  //Contains player1's team
        var warriors: [Warrior] = []
        warriors.append(contentsOf: players[0].warriors)
        return warriors
    }

    var warriors2: [Warrior] {  //Contains player2's team
        var warriors: [Warrior] = []
        warriors.append(contentsOf: players[1].warriors)
        return warriors
    }
    
    private var allWarriors: [Warrior] {  //Contains players' team
        var warriors: [Warrior] = []
        
        for player in players {
            warriors.append(contentsOf: player.warriors)
        }
        return warriors
    }
    
    static var allWarriorNames: [String] = [] //Contains all warrior's names
    

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
        repeat {
            for player in players {
                player.fight(allWarriors: allWarriors)
            }
        } while !((warriors1[0].hp == 0 && warriors1[1].hp == 0 && warriors1[2].hp == 0) || (warriors2[0].hp == 0 && warriors2[1].hp == 0 && warriors2[2].hp == 0))
//        if warriors1[0].hp == 0 && warriors1[1].hp == 0 && warriors1[2].hp == 0 {
//            print("🎉🥇 Player 2 is the WINNER !!! 🥇🎉")
//        } else if warriors2[0].hp == 0 && warriors2[1].hp == 0 && warriors2[2].hp == 0 {
//            print("🎉🥇 Player 1 is the WINNER !!! 🥇🎉")
//        }
            
            
//            while !players[0].isLooser || !players[1].isLooser
//        if players[0].isLooser {
//            print("Player 2 is the WINNER !!!")
//        } else if players[1].isLooser {
//            print("Player 1 is the WINNER !!!")
//        }
    }
    
    private func handleEndGame() {  //Ending phase
        
    }
}
