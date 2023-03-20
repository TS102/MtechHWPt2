//
//  ApiController.swift
//  RandomUserpt2
//
//  Created by Tyler Sun on 2/27/23.
//

import Foundation
import UIKit

protocol APIRequest {
    
    associatedtype Respone
    
    var urlRequest: URLRequest { get }
    func decodedResponse(data: Data) throws -> Respone
}

enum APIRequestError: Error {
    case itemNotFound
}

func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Respone {
    let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw APIRequestError.itemNotFound
    }
    
    let decodedResponse = try request.decodedResponse(data: data)
    return decodedResponse
}

struct GetUser: APIRequest {
    var query: String
    
    var urlRequest: URLRequest {
        let urlComponents = URLComponents(string: query)!
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodedResponse(data: Data) throws -> Results {
        let info = try JSONDecoder().decode(Results.self, from: data)
        
        print(info)
        return info
        
    }
    
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

enum PhotoInfoError: Error {
    case imageDataMissing
}

struct GetMultipleUsers: APIRequest {
    
    var urlRequest: URLRequest {
        let urlComponents = URLComponents(string: "https://randomuser.me/api/?results=30")!
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodedResponse(data: Data) throws -> Results {
        let info = try JSONDecoder().decode(Results.self, from: data)
        return info
    }
    
}
