// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Figlet

@main
struct advent_of_code_2025 {
    static func main() async {
        Figlet.say("Advent of Code 2025 :)")
        
        let results: [(Int, Int, Int, ContinuousClock.Instant.Duration)] = await process_days().sorted(by: { $0.0 < $1.0 })
        for result: (Int, Int, Int, ContinuousClock.Instant.Duration) in results {
            if (result.1, result.2) != (0, 0) {
                print("Day \(result.0) Part 1: '\(result.1)', Part 2: '\(result.2)', Execution Time: '\(result.3)'")
            }
        }
    }

    static func process_days() async -> [(Int, Int, Int, ContinuousClock.Instant.Duration)] {
        var results: [(Int, Int, Int, ContinuousClock.Instant.Duration)] = []

        let clock: ContinuousClock = ContinuousClock()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal

        await withTaskGroup(of: (Int, Int, Int, ContinuousClock.Instant.Duration).self) { group in

            for i: Int in 1...12 {
                group.addTask {
                    var result: (Int, Int) = (0, 0)
                    let executionTime = await clock.measure {
                        result = await execute_day(day: i)
                    }
                    return (i, result.0, result.1, executionTime)
                }
            }

            for await result in group {
                results.append(result)
            }
        }
        return results
    }

    static func execute_day(day: Int) async -> (Int, Int) {
        switch(day) {
            case 1:
                return await solve_day_1()
            case 2:
                return await solve_day_2()
            case 3:
                return await solve_day_3()
            case 4:
                return await solve_day_4()
            case 5:
                return await solve_day_5()
            case 6:
                return await solve_day_6()
            case 7:
                return await solve_day_7()
            case 8:
                return await solve_day_8()
            case 9:
                return await solve_day_9()
            case 10:
                return await solve_day_10()
            case 11:
                return await solve_day_11()
            case 12:
                return await solve_day_12()
            default:
                return (0, 0)
        }
    }
}
