// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Figlet

@main
struct advent_of_code_2025 {
    static func main() {
        Figlet.say("Advent of Code 2025 :)")
        
        let solutions: [String: () -> (Int, Int)] = [
            "day-1": solve_day_1,
            "day-2": solve_day_2,
            "day-3": solve_day_3,
            "day-4": solve_day_4,
            "day-5": solve_day_5,
            "day-6": solve_day_6,
            "day-7": solve_day_7,
            "day-8": solve_day_8,
            "day-9": solve_day_9,
            "day-10": solve_day_10,
            "day-11": solve_day_11,
            "day-12": solve_day_12,
        ]

        let clock: ContinuousClock = ContinuousClock()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal

        for solution: String in solutions.keys.sorted(using: .localizedStandard) {
            var value: (Int, Int) = (0, 0)
            let executionTime = clock.measure {
                value = solutions[solution]!()
            }
            if value == (0, 0) {
                continue
            }
            print("\(solution) Part 1: '\(value.0)', Part 2: '\(value.1)', Execution Time: '\(executionTime)'")
        }
    }
}
