import Foundation

func solve_day_3(input: String) async -> (Int, Int) {
    var total_joltage: Int = 0
    var mega_joltage: Int = 0

    input.enumerateLines(invoking: { line, stop in 
        var digits: [Int] = []

        for (_, char) in line.enumerated() {
            digits.append(Int(String(char)) ?? -1)
        }
        
        // Part 1
        var current_max: Int = 0
        for i: Int in 0..<digits.count {
            for j: Int in i+1..<digits.count {
                let combined: Int = digits[i] * 10 + digits[j]
                if combined > current_max {
                    current_max = combined
                }
            }
        }
        total_joltage += current_max

        // Part 2
        var indices: [Int] = []
        var initial_max: Int = 0
        var initial_index: Int = 0
        for i: Int in 0..<digits.count-11 {
            if digits[i] > initial_max {
                initial_max = digits[i]
                initial_index = i
            }
        }
        indices.append(initial_index)

        current_max = 0
        var current_index: Int = 0
        for limit: Int in 0..<11 {
            for i: Int in (indices.last ?? -1)+1..<digits.count-(10-limit) {
                if digits[i] > current_max {
                    current_max = digits[i]
                    current_index = i
                }
            }
            indices.append(current_index)
            current_index = 0
            current_max = 0
        }

        var joltage: Int = 0
        for idx: Int in indices {
            joltage *= 10
            joltage += digits[idx]
        }

        mega_joltage += joltage
    })
    return (total_joltage, mega_joltage)
}