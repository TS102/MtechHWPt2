//
//  Player.swift
//  Scorekeeper
//
//  Created by Tyler Sun on 11/7/22.
//

import Foundation
import UIKit

struct Player: Codable {
    var name: String
    var score: Int
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appending(component: "Player").appendingPathExtension("plists")
    
    static func loadPLayers() -> [Player]? {
        guard let codedPlayers = try? Data(contentsOf: archiveURL) else { return nil }
        let propertListDecoder = PropertyListDecoder()
        return try? propertListDecoder.decode(Array<Player>.self, from: codedPlayers)
    }
    
    static func savePlayers(player: Player) {
        let properListEncoder = PropertyListEncoder()
        let codedPlayers = try? properListEncoder.encode(player)
        try? codedPlayers?.write(to: archiveURL, options: .noFileProtection)
    }
    
}
