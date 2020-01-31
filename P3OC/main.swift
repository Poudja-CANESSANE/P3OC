//
//  main.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

// Mettre le jeu en place (GameManager!!!)
// en demandant à chaque (boucle for) joueur (Player!!!) de créer les guerriers (Warrior!!!) (player.createWarriors())
// de son équipe (numberOfWarriorPerTeam = 3, var warriors: [Warrior] = []).
// (createWarrior()) Le joueur devra choisir pour chaque personnage un nom différent de tous les autres personnages déjà créés dans le jeu (askWarriorName(existingWarriors: [Warrior]).


let gameManager = GameManager()
gameManager.startGame()
