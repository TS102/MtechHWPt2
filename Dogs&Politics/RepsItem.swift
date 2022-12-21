//
//  RepsItem.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/5/22.
//

import Foundation

struct RepsItem: Codable {
    var name: String
    var state: String
    var district: String
    var link: String

    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case state = "state"
        case district = "district"
        case link = "link"

    }
    
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        state = try values.decode(String.self, forKey: CodingKeys.state)
        district = try values.decode(String.self, forKey: CodingKeys.district)
        link = try values.decode(String.self, forKey: CodingKeys.link)
    }
}

struct SearchResponse: Codable {
    let results: [RepsItem]
}
