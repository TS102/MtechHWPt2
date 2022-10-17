/*:
## Exercise - Adopt Protocols: CustomStringConvertible, Equatable, and Comparable
 
 Create a `Human` class with two properties: `name` of type `String`, and `age` of type `Int`. You'll need to create a memberwise initializer for the class. Initialize two `Human` instances.
 */

import Foundation
class Human: CustomStringConvertible, Equatable, Comparable, Codable {
    static func < (lhs: Human, rhs: Human) -> Bool {
        return lhs.age < rhs.age
    }
    var name: String
    var age: Int
    init(name:String, age: Int) {
        self.age = age
        self.name = name
    }
    
    var description: String {
        return "name is \(name) and is \(age) years old."
    }
    static func == (lhs: Human, rhs: Human) -> Bool {
        return lhs.age == rhs.age && lhs.name == rhs.name
    }
    
}

var person1 = Human(name: "Tyler", age: 20)
var person2 = Human(name: "jon", age: 99)

//:  Make the `Human` class adopt the `CustomStringConvertible` protocol. Print both of your previously initialized `Human` objects.
print(person1)
print(person2)

//:  Make the `Human` class adopt the `Equatable` protocol. Two instances of `Human` should be considered equal if their names and ages are identical to one another. Print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are equal to eachother (using `==`). Then print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are not equal to eachother (using `!=`).
print(person1 == person2)
print(person1 != person2  )

//:  Make the `Human` class adopt the `Comparable` protocol. Sorting should be based on age. Create another three instances of a `Human`, then create an array called `people` of type `[Human]` with all of the `Human` objects that you have initialized. Create a new array called `sortedPeople` of type `[Human]` that is the `people` array sorted by age.
let chet = Human(name: "chet", age: 24)
let george = Human(name: "george", age: 77)
let gabe = Human(name: "gabe", age: 31)
var people: [Human] = [chet, george, gabe]
var sortedPeople: [Human] = [chet, george, gabe].sorted(by: <)
print(sortedPeople)

//:  Make the `Human` class adopt the `Codable` protocol. Create a `JSONEncoder` and use it to encode as data one of the `Human` objects you have initialized. Then use that `Data` object to initialize a `String` representing the data that is stored, and print it to the console.

let jsonEncoder = JSONEncoder()

if let jsonData = try? jsonEncoder.encode(chet),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}

/*:
page 1 of 5  |  [Next: App Exercise - Printable Workouts](@next)
 */
