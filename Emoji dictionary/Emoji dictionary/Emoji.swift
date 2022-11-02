//
//  Emoji.swift
//  Emoji dictionary
//
//  Created by Tyler Sun on 10/18/22.
//

import Foundation

struct Emoji: Codable {
     var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var emojiURl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("EmojiSaveData").appendingPathExtension("json")

    static func saveToFile(emojis: [Emoji]) {
        guard let dataObject = try? JSONEncoder().encode(emojis) else { return }
        do {
            try dataObject.write(to: emojiURl)
        } catch {
            print(error)
        }
    }

    static func loadFromFile() -> [Emoji]{
        let data = try! Data(contentsOf: emojiURl)
        do {
            return try JSONDecoder().decode([Emoji].self, from: data)
        } catch {
            print(error)
            return []
        }
       
    }
    
}

