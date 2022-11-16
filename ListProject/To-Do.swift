//
//  To-Do.swift
//  ListProject
//
//  Created by Tyler Sun on 11/4/22.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appending(component: "toDos").appendingPathExtension("plists")
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleToDo() -> [ToDo] {
        
        let toDo1 = ToDo(title: "hello", isComplete: true, dueDate: Date(), notes: "notes 1")
        let toDo3 = ToDo(title: "gym", isComplete: true, dueDate: Date(), notes: "notes 3")
        return [toDo1, toDo3]
    }
    
    
}

