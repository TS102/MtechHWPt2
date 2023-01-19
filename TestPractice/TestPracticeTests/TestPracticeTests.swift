//
//  TestPracticeTests.swift
//  TestPracticeTests
//
//  Created by Tyler Sun on 1/3/23.
//

import XCTest
@testable import TestPractice

final class TestPracticeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_players_WithOptionalParams() {
        let playerOne = Person(name: "jim", age: 39, height: 5, weight: 178)
        XCTAssert(playerOne.age == 39)
        XCTAssert(playerOne.name == "jim")
        XCTAssert(playerOne.height == 5)
    }
    
    func test_Person_WithoutOptionalParams() {
        let person = Person(name: "bob", age: 23)
        XCTAssert(person.height == nil)
        XCTAssert(person.weight == nil)
    }
    
    func test_Person_InputChange() {
        var person = Person(name: "tyler", age: 20)
        person.name = "sally"
        person.age = 80
        
        XCTAssert(person.name == "sally")
        XCTAssert(person.age == 80)
    }
    
    func test_PersonOptionalParams_Added() {
        var person = Person(name: "markus", age: 78)
        person.weight = 125
        person.height = 5
        
        XCTAssert(person.weight == 125 && person.height == 5)
    }
    
// every func that starts with the word tests are considered test
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
