//
//  RepresentativesController.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/5/22.
//

import Foundation


class RepItemsController {
    
    enum RepItemError: Error, LocalizedError {
        case error
    }
    
    
    func fetchItems(matching query: [String: String]) async throws -> [RepsItem] {
        var urlCompononents = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php")!
        urlCompononents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        let (data, respone) = try await URLSession.shared.data(from: urlCompononents.url!)
        guard let httpResponse = respone as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw RepItemError.error
              }
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
    
        print(searchResponse.results)
        return searchResponse.results
    }
}
