//
//  GameManager.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

class GameManager {

// MARK: - INTERNAL
    
// MARK: - Methods
    
    ///Manage each phase of the game
    func startGame() {
        print("\n                    ***** Welcome to BATTLE OF WARRIORS ! *****"
            + "\nYou will create 3 warriors. And then you can select one who will attack an enemy or heal a teammate.")
        createPlayers()
        startTeamCreationPhase()
        startFightingPhase()
        handleEndGame()
    }
    
// MARK: - PRIVATE
    
// MARK: - Properties
    
    ///This is the number of player
    private let numberOfPlayer: Int = 2
    
    ///Contains players of the game
    private var players: [Player] = []
    
     ///This is the number of round
    private var numberOfRound: Int = 0
    
    ///To know if the game is over (when all the warriors of a team are dead)
    private var isGameOver: Bool {
        players[0].isLooser || players[1].isLooser
    }
    
// MARK: - Methods
    
// MARK: - Initialization Phase
    
     ///Create 2 players and fill players array with them
    private func createPlayers() {
        for playerId in 1...numberOfPlayer {
            let player = Player(id: playerId)
            players.append(player)
        }
    }
    
    ///Create a team for each player
    private func startTeamCreationPhase() {
        for player in players {
            player.createWarriors(allPlayers: players)
        }
    }
    
// MARK: - Fighting Phase
    
    ///Each player can alternatively attack an opponent or heal a teammate while the game is not over
    private func startFightingPhase() {
        while !isGameOver {
            for player in players where !isGameOver {
                    let opponentPlayer = getOpponentPlayerFrom(currentPlayer: player)
                    player.fight(opponent: opponentPlayer)
                    numberOfRound += 1
            }
        }
    }
    
    ///To know which of the two players is the opponent of the current player
    private func getOpponentPlayerFrom(currentPlayer: Player) -> Player {
        switch currentPlayer.id {
        case 1: return players[1]
        case 2: return players[0]
        default: printWarning(msg: "ERROR ! Cannot get the opponent player from the current player.")
                 return currentPlayer
        }
    }
    
// MARK: - Ending Phase
    
    ///Print the winner, the number of round, players' team and ask if the players want to restart the game
    private func handleEndGame() {
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
        if loopAskToRestartGame() {
            resetGame()
            startGame()
        }
    }
    
    ///Clear players array and reset numberOfRound to 0
    private func resetGame() {
        players.removeAll()
        numberOfRound = 0
    }
    
    ///Ask if the players want to play again while the 3 guard statement are not satisfied
    private func loopAskToRestartGame() -> Bool {
        print("\nDo you want to play again ?"
            + "\n1. YES"
            + "\n2. NO")
        
        guard let restartOptionalString = readLine() else {
            printWarning(msg: "The input is invalid")
            return loopAskToRestartGame()
        }
        
        guard let restartIndex = Int(restartOptionalString) else {
            printWarning(msg: "Please enter a number.")
            return loopAskToRestartGame()
        }
        
        guard 1...2 ~= restartIndex else {
            printWarning(msg: "Make sure to enter 1 or 2.")
            return loopAskToRestartGame()
        }
        
        switch restartIndex {
        case 1: return true
        case 2: return false
        default: return false
        }
    }
}
