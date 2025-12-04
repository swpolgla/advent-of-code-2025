import Foundation

func solve_day_4(input: String) async -> (Int, Int) {

    var accessible_rolls: Int = 0
    var more_rolls: Int = 0

    // Construct 140x140 grid
    var grid: [142 of [142 of Int]] = .init(repeating: [142 of Int].init(repeating: 0))

    // Convert String format map to 2D Int Array
    var line_counter: Int = 0
    input.enumerateLines(invoking: { line, stop in 
        for (idx, char) in line.enumerated() {
            grid[line_counter+1][idx+1] = (char == "@") ? 1 : 0
        }
        line_counter += 1
    })

    // Loop over array looking for accessible rolls
    // Mark accessible rolls for deletion
    // Clear all accessible rolls from the map
    // Loop again
    var iteration: Int = 0
    var changes: Int = 0
    while true {
        for i: Int in 1..<141 {
            for j: Int in 1..<141 {
                if grid[i][j] > 0 {
                    var neighbors: Int = 0
                    for x: Int in i-1...i+1 {
                        for y: Int in j-1...j+1 {
                            if grid[x][y] > 0 && !(x == i && y == j) {
                                neighbors += 1
                            }
                        }
                    }
                    if neighbors < 4 {
                        if iteration == 0 {
                            accessible_rolls += 1
                        }
                        more_rolls += 1
                        changes += 1
                        grid[i][j] = 2
                    }
                }
            }
        }
        if changes == 0 {
            break
        }
        changes = 0
        iteration += 1

        for i: Int in 1..<141 {
            for j: Int in 1..<141 {
                if grid[i][j] == 2 {
                    grid[i][j] = 0
                }
            }
        }
    }

    return (accessible_rolls, more_rolls)
}
