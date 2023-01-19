//
//  NumbersTest.swift
//  TestPracticeTests
//
//  Created by Tyler Sun on 1/3/23.
//

import XCTest
@testable import TestPractice

final class NumbersTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_OddNumbers() {
        let evenNumber = NumberController.evenNumbers(numbers: [1,3,4,5,7,9,11,12])
        let oddNumbers = [1,3,5,7,9,11]
        
        XCTAssertNotEqual(oddNumbers, evenNumber)
    }
    
    func test_EvenNumbers() {
        let evenNums = NumberController.evenNumbers(numbers: [4,3,8,7,2,9,6])
        let evenNumbers = [4,8,2,6]
        
       XCTAssertEqual(evenNums, evenNumbers)
    }
    
    func test_EvenNumbers_WithDifferentResults() {
        let evenNums = NumberController.evenNumbers(numbers: [2,3,6,8])
        let evenNumbers = [2,6,8]
        XCTAssertEqual(evenNums, evenNumbers)
    }
    
    func test_IsEmpty() {
        let evenNumbers = NumberController.evenNumbers(numbers: [])
        XCTAssert(evenNumbers == [])
    }
    
    func test_NegativeEvenNumbers() {
        let evenNums = NumberController.evenNumbers(numbers: [-4,-2,-6])
        let negativeNumbers = [-4,-2,-6]
        XCTAssertEqual(evenNums, negativeNumbers)
    }
    
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

