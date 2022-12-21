//
//  DogController.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/4/22.
//

import Foundation
import UIKit


struct DogItem: Codable {
    var dogImage: URL
    
    enum CodingKeys: String, CodingKey {
        case dogImage = "message"
    }
}

class DogController {

    enum PhotoInfoError: Error, LocalizedError {
        case itemNotFound
        case imageDataMissing
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw PhotoInfoError.imageDataMissing
        }
        
        guard let image = UIImage(data: data) else {
            throw PhotoInfoError.imageDataMissing
        }
        
        return image
    }
    
    func fetchItems() async throws -> DogItem {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw PhotoInfoError.itemNotFound
              }
        
        let jsonDecoder = JSONDecoder()
        let photo = try jsonDecoder.decode(DogItem.self, from: data)
        print(photo)
        return photo
        
    }
    
    
    
}

