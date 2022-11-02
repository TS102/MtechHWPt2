//
//  Family.swift
//  FamilyProjectpt2
//
//  Created by Tyler Sun on 11/1/22.
//

import Foundation

struct Family {
    var name: String
    let familyInfo: [FamilyInfo]
    
    init(name: String, familyInfo: [FamilyInfo]) {
        self.name = name
        self.familyInfo = familyInfo
    }
}
