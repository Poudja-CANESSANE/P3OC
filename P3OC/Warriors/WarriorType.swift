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
    
    var description: String {
        switch self {
        case .magus: return "🎩"
        case .knight: return "⚔️"
        case .archer: return "🏹"
        }
    }
}
