//
//  WarriorType.swift
//  P3OC
//
//  Created by Canessane Poudja on 31/01/2020.
//  Copyright © 2020 Canessane Poudja. All rights reserved.
//

import Foundation

enum WarriorType: String, CaseIterable {
    case magus, knight, archer
    
// MARK: - INTERNAL
    
// MARK: Properties
    
    var description: String {
        switch self {
        case .magus: return "🎩"
        case .knight: return "⚔️"
        case .archer: return "🏹"
        }
    }
    
    var extendedDescription: String {
        description + " " + nameCapitalized
    }
    
    var maxHp: Int {
        switch self {
        case .magus: return Magus.maxHp
        case .archer: return Archer.maxHp
        case .knight: return Knight.maxHp
        }
    }
    
    var magicPoints: Int {
        switch self {
        case .magus: return Magus.magicPoints
        case .archer: return Archer.magicPoints
        case .knight: return Knight.magicPoints
        }
    }
    
    var weapon: Weapon {
        switch self {
        case .magus: return .stone
        case .archer: return .bow
        case .knight: return .sword
        }
    }
    
// MARK: - PRIVATE
    
// MARK: Properties
    
    private var nameCapitalized: String {
        self.rawValue.prefix(1).uppercased() + self.rawValue.dropFirst()
    }
}
