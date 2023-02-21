//
//  LifeForm.swift
//  Life-FormSearch
//
//  Created by Tyler Sun on 1/20/23.
//
import UIKit
import Foundation

// MARK: for the tableview controller
protocol APiRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}
    
    enum APIRequestError: Error {
        case itemNotFound
    }
    
func sendRequest<Request: APiRequest>(_ request: Request) async throws -> Request.Response {
    
    let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
    
    guard let httpRespone = response as? HTTPURLResponse,
          httpRespone.statusCode == 200 else {
        throw APIRequestError.itemNotFound
    }
    
    let decodeResponse = try request.decodeResponse(data: data)
    return decodeResponse
}


// MARK: For the detail tableview controller
struct DataInfoRevquest: APiRequest {
    var searchText: String
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://eol.org/api/search/1.0.json")!
        urlComponents.queryItems = [URLQueryItem(name: "q", value: searchText)]
        print(urlComponents.url!)
        
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> SearchResponse {
        let Info = try JSONDecoder().decode(SearchResponse.self, from: data)
        
        return Info
    }
}

struct DetailInfoRequest: APiRequest {
    var id: Int
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://eol.org/api/pages/1.0/\(id).json")!
        urlComponents.queryItems = [URLQueryItem(name: "images_per_page", value: "1"), URLQueryItem(name: "taxonomy", value: "false")]
        print(urlComponents.url!)
        
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> PageResponse {
        let info = try JSONDecoder().decode(PageResponse.self, from: data)
        
        return info
    }
}

//func fetchImage(from url: URL) async throws -> UIImage {
//    let (data, response) = try await URLSession.shared.data(from: url)
//    
//    guard let httpResponse = response as? HTTPURLResponse,
//          httpResponse.statusCode == 200 else {
//        throw PhotoInfoError.imageDataError
//    }
//    
//    guard let image = UIImage(data: data) else {
//        throw PhotoInfoError.imageDataError
//    }
//    
//    return image
//    
//}
