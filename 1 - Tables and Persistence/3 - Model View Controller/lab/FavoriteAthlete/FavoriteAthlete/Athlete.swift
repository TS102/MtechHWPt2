//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Tyler Sun on 10/13/22.
//

import Foundation

struct Athlete: CustomStringConvertible {
    var name: String
    var age: Int
    var league: String
    var team: String
    
    var description: String {
        return "Your favorite player is \(name) age is \(age) years old. Plays for \(team) in the \(league)."
    }
}


