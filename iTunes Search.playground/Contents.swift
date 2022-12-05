import UIKit

struct StoreItem: Codable {
    var title: String
    var releaseDate: String
    var director: String
    var genre: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case releaseDate = "releaseDate"
        case director = "artistName"
        case genre = "primaryGenreName"
        case description = "description"
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

enum StoreItemError: Error, LocalizedError {
    case error
}

func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
    var urlComponents = URLComponents(string:
           "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key,
           value: $0.value) }
        let (data, response) = try await URLSession.shared.data(from:
           urlComponents.url!)
            guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else {
                throw StoreItemError.error
        }

        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self,
           from: data)

        return searchResponse.results
}

let query = [
    "term": "apple",
    "media": "movie",
    "attribute": "actorTerm",
    "limit": "10"
]

Task {
    do {
        let storeItems = try await fetchItems(matching: query)
        storeItems.forEach { item in
            print("""
            title: \(item.title)
            Director: \(item.director)
            genre: \(item.genre)
            releaseDate: \(item.releaseDate)
            longDescription: \(item.description)
            """)
        }
    } catch {
        print(error)
    }
}



//var urlComponents = URLComponents(string: "htjtps://itunes.apple.com/search?")!
//urlComponents.queryItems = [
//    "media": "movie",// for the query items you have to put the api names exactly how it is in the api website
//    "limit": "2", // only shows results of the first five or whatever number you put in it.
//    "term": "avengers" // shows what you want to search in this case marvel movies
//].map { URLQueryItem(name: $0.key, value: $0.value) } // map the query items so that you can get of the error that will appear.
//
//
//extension Data { // this extension makes the json more readable for you
//    func prettyPrintedJsonString() {
//        guard
//            let jsonOjbect = try?
//                JSONSerialization.jsonObject(with: self, options: []),
//            let jsonData = try? JSONSerialization.data(withJSONObject: jsonOjbect,options: [.prettyPrinted]),
//            let prettyJsonString = String(data: jsonData, encoding: .utf8) else {
//            print("Failed to read json object.")
//            return
//        }
//        print(prettyJsonString)
//    }
//}
//
//Task {
//    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
//
//    if let httpResponse = response as? HTTPURLResponse,
//       httpResponse.statusCode == 200 {
//        data.prettyPrintedJsonString()
//    }
//
//}
