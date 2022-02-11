//
//  main.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

//func input() -> String {
//    let keyboard = FileHandle.standardInput
//    let inputData = keyboard.availableData
//    return String(data: inputData, encoding: .utf8)!
//}

var temperature, open_inches : Double
var weights = [Double](repeating: 0, count: 3)

var temperature_set = FuzzySet(size: 4)
var set_result = FuzzySet(size: 3)
var memory = FAM(setqty: 3, setlen: 4)

var cold = trapezoidMembership(-24.0, -8.0, 8.0, 24.0)
var cool = trapezoidMembership(8.0, 24.0, 40.0, 48.0)
var warm = trapezoidMembership(40.0, 56.0, 72.0, 88.0)
var hot = trapezoidMembership(72.0, 88.0, 104.0, 120.0)

var closed = trapezoidMembership(0.0, 2.0, 4.0, 8.0)
var part_open = trapezoidMembership(4.0, 8.0, 10.0, 14.0)
var open = trapezoidMembership(10.0, 14.0, 16.0, 18.0)

print("Enter the outside temperature (in ℉):")
let input = readLine()!
let t = input.replacingOccurrences(of: "\n", with: "")
temperature = Double(t)!

temperature_set[0] = cold.membership(temperature)
temperature_set[1] = cool.membership(temperature)
temperature_set[2] = warm.membership(temperature)
temperature_set[3] = hot.membership(temperature)
print("Temperature set = \(temperature_set)")

memory[0][0] = 1.0
memory[0][1] = 0.5
memory[0][2] = 0.3
memory[0][3] = 1.0
memory[1][0] = 0.5
memory[1][1] = 0.5
memory[1][2] = 0.8
memory[1][3] = 0.0
memory[2][0] = 0.0
memory[2][1] = 0.5
memory[2][2] = 1.0
memory[2][3] = 0.0

set_result = temperature_set * memory
print("Result set = \(set_result)")

weights[0] = closed.weight(set_result[0])
weights[1] = part_open.weight(set_result[1])
weights[2] = open.weight(set_result[2])

open_inches = ((weights[0] * 3.0) + (weights[1] * 9.0) + (weights[2] * 15.0)) / (weights[0] + weights[1] + weights[2])
print("open \(open_inches) inches")

exit(1)
