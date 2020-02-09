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
    
    let numberOfPlayer: Int = 2  //This is the number of player
    private var players: [Player] = []  //Contains players of the game
    private var numberOfRound: Int = 0  //This is the number of round
    private var isGameOver: Bool {  //To know if the game is over (when all the warriors of a team are dead)
        players[0].isLooser || players[1].isLooser
    }
    
//===========================
// MARK: - METHODS - INTERNAL
//===========================
    
    func startGame() {  //Manage each phase of the game
        createPlayers()
        startTeamCreationPhase()
        startFightingPhase()
        handleEndGame()
    }
    
//==========================
// MARK: - METHODS - PRIVATE
//==========================
    
//=============================
// MARK: - Initialization Phase
//=============================
    
    private func createPlayers() {  //Create 2 players and fill players array with them
        for playerId in 1...numberOfPlayer {
            let player = Player(id: playerId)
            players.append(player)
        }
    }
    
    private func startTeamCreationPhase() {  //Create a team for each player
        for player in players {
            player.createWarriors(allPlayers: players)
        }
    }
    
//=======================
// MARK: - Fighting Phase
//=======================
    
    private func startFightingPhase() {  //Each player can alternatively attack an opponent or heal a teammate while                                      the game is not over
        while !isGameOver {
            for player in players {
                if !isGameOver {
                    guard let opponentPlayer = getOpponentPlayerFrom(currentPlayer: player) else { return }
                    player.fight(opponent: opponentPlayer)
                    numberOfRound += 1
                }
            }
        }
    }
    
    private func getOpponentPlayerFrom(currentPlayer: Player) -> Player? {  //To know which of the two players is the                                                                        opponent of the current player
        for player in players where player.id != currentPlayer.id  {
            return player
        }
        return nil
    }
    
//=====================
// MARK: - Ending Phase
//=====================
    
    private func handleEndGame() {  //Print the winner, the number of round, players' team and ask if the players want                               to restart the game
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
        let wantToRestart = loopAskToRestartGame()
        if wantToRestart == true {
            resetGame()
            startGame()
        }
    }
    
    private func resetGame() {  //Clear players array and reset numberOfRound to 0
        players.removeAll()
        numberOfRound = 0
    }
    
    
    private func askToRestartGame() -> Bool? {  //Ask if the players want to play again
        print("\nDo you want to play again ?"
            + "\n1. YES"
            + "\n2. NO")
        
        guard let restartOptionalString = readLine() else {
            printWarning(msg: "The input is invalid")
            return nil
        }
        
        guard let restartIndex = Int(restartOptionalString) else {
            printWarning(msg: "Please enter a number.")
            return nil
        }
        
        guard restartIndex == 1 || restartIndex == 2 else {
            printWarning(msg: "Make sure to enter 1 or 2.")
            return nil
        }
        
        switch restartIndex {
        case 1: return true
        case 2: return false
        default: return false
        }
    }
    
    
    private func loopAskToRestartGame() -> Bool {  //Ask if the players want to play again while wantToRestart is nil
        var wantToRestart: Bool? = nil
        while wantToRestart == nil  {
            wantToRestart = askToRestartGame()
        }
        return wantToRestart!
    }
}
