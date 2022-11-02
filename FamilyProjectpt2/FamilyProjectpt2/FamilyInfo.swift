//
//  FamilyInfo.swift
//  FamilyProjectpt2
//
//  Created by Tyler Sun on 11/1/22.
//

import Foundation

struct FamilyInfo {
    let name: String
    let description: String
    let age: String
    let imageData: Data?
    
    init(name: String, description: String, age: String, imageData: Data? = nil) {
        self.name = name
        self.description = description
        self.age = age
        self.imageData = imageData
    }
}
