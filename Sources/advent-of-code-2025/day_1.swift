import Foundation

func solve_day_1(input: String) async -> (Int, Int) {
    var tumbler_value: Int = 50

    var password_success: Int = 0
    var zero_ticks: Int = 0

    input.enumerateLines(invoking: { line, stop in 
        let direction: Int = line.first == "R" ? 1 : -1
        let ticks: Int = Int(line.dropFirst()) ?? -1

        for _ in 0..<ticks {
            tumbler_value += direction

            if tumbler_value == -1 {
                tumbler_value = 99
            }
            else if tumbler_value == 100 {
                tumbler_value = 0
            }

            if tumbler_value == 0 {
                zero_ticks += 1
            }
        }

        if tumbler_value == 0 {
            password_success += 1
        }
    })

    return (password_success, zero_ticks)
}
