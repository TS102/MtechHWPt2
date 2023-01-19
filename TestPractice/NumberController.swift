//
//  NumberController.swift
//  TestPractice
//
//  Created by Tyler Sun on 1/3/23.
//

import Foundation

struct NumberController {
    static func evenNumbers(numbers: [Int]) -> [Int] {
        var evenNums = [Int]()
        for num in numbers {
            if num % 2 == 0 {
                evenNums.append(num)
            }
        }
  return evenNums
    }
}
