// The Swift Programming Language
// https://docs.swift.org/swift-book
import Figlet

@main
struct advent_of_code_2025 {
    static func main() async {
        Figlet.say("Advent of Code 2025 :)")

        let inputs: [String] = read_inputs()
        
        let results: [(Int, Int, Int, ContinuousClock.Instant.Duration)] = await process_days(inputs: consume inputs).sorted(by: { $0.0 < $1.0 })
        for result: (Int, Int, Int, ContinuousClock.Instant.Duration) in results {
            if (result.1, result.2) != (0, 0) {
                print("Day \(result.0) Part 1: '\(result.1)', Part 2: '\(result.2)', Execution Time: '\(result.3)'")
            }
        }
    }

    static func process_days(inputs: [String]) async -> [(Int, Int, Int, ContinuousClock.Instant.Duration)] {
        var results: [(Int, Int, Int, ContinuousClock.Instant.Duration)] = []

        let clock: ContinuousClock = ContinuousClock()

        await withTaskGroup(of: (Int, Int, Int, ContinuousClock.Instant.Duration).self) { group in

            for i: Int in 1...12 {
                let input: String = inputs[i - 1]
                group.addTask {
                    var result: (Int, Int) = (0, 0)
                    let executionTime = await clock.measure {
                        result = await execute_day(day: i, input: input)
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

    static func execute_day(day: Int, input: String) async -> (Int, Int) {
        switch(day) {
            case 1:
                return await solve_day_1(input: input)
            case 2:
                return await solve_day_2(input: input)
            case 3:
                return await solve_day_3(input: input)
            case 4:
                return await solve_day_4(input: input)
            case 5:
                return await solve_day_5(input: input)
            case 6:
                return await solve_day_6(input: input)
            case 7:
                return await solve_day_7(input: input)
            case 8:
                return await solve_day_8(input: input)
            case 9:
                return await solve_day_9(input: input)
            case 10:
                return await solve_day_10(input: input)
            case 11:
                return await solve_day_11(input: input)
            case 12:
                return await solve_day_12(input: input)
            default:
                return (0, 0)
        }
    }

    static func read_inputs() -> [String] {
        var inputs: [String] = []
        for i in 1...12 {
            inputs.append(read_input(path: "inputs/day-\(i).txt"))
        }
        return inputs
    }

    @inlinable
    static func read_input(path: String) -> String {
        return try! String(contentsOfFile: path, encoding: String.Encoding.ascii).trimmingCharacters(in: .newlines)
    }
}
