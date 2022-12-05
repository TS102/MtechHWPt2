//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Tyler Sun on 12/1/22.
//

import Foundation


struct StoreItem: Codable {
    var title: String
    var releaseDate: String
    var director: String
    var genre: String
    var description: String
    var artWorkUrl: URL

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case releaseDate = "releaseDate"
        case director = "artistName"
        case genre = "primaryGenreName"
        case description = "description"
        case artWorkUrl = "artworkUrl100"
    }

    enum AdditionalKeys: String, CodingKey {
        case longDescription = "longDescripton"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        director = try values.decode(String.self, forKey: CodingKeys.director)
        genre = try values.decode(String.self, forKey: CodingKeys.genre)
        releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
        artWorkUrl = try values.decode(URL.self, forKey: CodingKeys.artWorkUrl)

        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy:
               AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self,
               forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}
