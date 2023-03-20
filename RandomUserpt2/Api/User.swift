//
//  User.swift
//  RandomUserpt2
//
//  Created by Tyler Sun on 2/27/23.
//

import Foundation

struct Name: Codable {
    var title: String?
    var first: String?
    var last: String?
}

struct Location: Codable {
    var street: Street
    var city: String
    var state: String
    var country: String
    var postcode: String
    var coordinates: Coordinates
    var timeZone: TimeZone
}

struct Street: Codable {
    var number: Int?
    var name: String?
}

struct Coordinates: Codable {
    var latitude: String?
    var longitude: String?
}

struct TimeZone: Codable {
    var offSet: String?
    var description: String?
}

struct Login: Codable {
    var uuid: String?
    var userName: String?
    var passWord: String?
    var md5: String?
    var sha1: String?
    var sha256: String?
}

struct DOB: Codable {
    var date: String
    var age: Int
}

struct Registered: Codable {
    var date: String?
    var age: Int?
}

struct Id: Codable {
    var name: String?
    var value: String?
}

struct Picture: Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

struct User: Codable {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob: DOB?
    var registered: Registered?
    var phone: String?
    var cell: String?
    var id: Id?
    var picture: Picture?
    var nat: String?
}

struct Info: Codable {
    var seed: String
    var results: Int
    var page: Int
    var version: String
}

struct Results: Codable {
    var results: [User]
    var info: Info
}

