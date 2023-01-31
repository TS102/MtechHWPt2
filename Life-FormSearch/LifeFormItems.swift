//
//  LifeFormItems.swift
//  Life-FormSearch
//
//  Created by Tyler Sun on 1/23/23.
//

import Foundation

struct LifeForm: Codable {
    var id: Int
    var title: String
    var link: String
    var content: String
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case link
        case content
    }
}

struct SearchResponse: Codable {
    let results: [LifeForm]
}


struct PageResponse: Codable {
    var taxonConcept: TaxonConcept
}

struct TaxonConcept: Codable {
    var identifier: Int?
    var scientificName: String?
    var dataObjects: [DataObject]?
}

struct DataObject: Codable {
    var mediaURL: String
}


enum PhotoInfoError: Error {
    case imageDataError
}


