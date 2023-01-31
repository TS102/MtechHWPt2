//
//  SearchScope.swift
//  iTunesSearch
//
//  Created by Tyler Sun on 1/26/23.
//

import Foundation


enum SearchScope: CaseIterable {
case all, movies, music, apps, books
    
    var title: String {
        switch self {
        case .all: return "all"
        case .music: return "Music"
        case .movies: return "Movies"
        case .apps: return "software"
        case .books: return "ebook"
        }
    }
    
    var mediaType: String {
        switch self {
        case .all: return "all"
        case .music: return "music"
        case .movies: return "movie"
        case .apps: return "software"
        case .books: return "ebook"
        }
    }
    
    
}
