import Foundation

func solve_day_5(input: String) async -> (Int, Int) {

    var non_spoiled_ids: Int = 0
    var total_non_spoiled_ids: Int = 0

    var non_spoiled: [182 of ClosedRange<Int>] = [182 of ClosedRange<Int>].init(repeating: 0...1)
    var ingredient_ids: [1000 of Int] = [1000 of Int].init(repeating: 0)

    // Convert String format map to 2D Int Array
    var counter: Int = 0
    var counter2: Int = 0
    var reading_ranges: Bool = true
    input.enumerateLines(invoking: { line, stop in 
        if line.count == 0 {
            reading_ranges = false
        }
        else if reading_ranges {
            let range: [String.SubSequence] = line.split(separator: "-")
            let start: Int = Int(range[0]) ?? -1
            let end: Int = Int(range[1]) ?? -1

            non_spoiled[counter] = start...end
            counter += 1
        }
        else {
            ingredient_ids[counter2] = Int(line) ?? -1
            counter2 += 1
        }
    })

    for i: Int in 0..<ingredient_ids.count {
        for j: Int in 0..<non_spoiled.count {
            if non_spoiled[j].contains(ingredient_ids[i]) {
                non_spoiled_ids += 1
                break
            }
        }
    }

    var non_spoiled_sorted: [ClosedRange<Int>] = []
    for i: Int in 0..<non_spoiled.count {
        if non_spoiled[i] != 0...1 {
            non_spoiled_sorted.append(non_spoiled[i])
        }
    }

    non_spoiled_sorted.sort(by: { $0.first ?? -1 > $1.first ?? -1 })

    var final: [ClosedRange<Int>] = []
    var current: ClosedRange<Int> = non_spoiled_sorted[0]
    for i: Int in 1..<non_spoiled_sorted.count {
        let a_first: Int = Int(current.first ?? -1)
        let a_last: Int = Int(current.last ?? -1)
        let b_first: Int = Int(non_spoiled_sorted[i].first ?? -1)
        let b_last: Int = Int(non_spoiled_sorted[i].last ?? -1)
        if b_last >= a_first && b_first <= a_last {
            current = (min(a_first, b_first)...max(a_last, b_last))
        }
        else {
            final.append(current)
            current = non_spoiled_sorted[i]
        }
    }
    final.append(current)

    for x: ClosedRange<Int> in final {
        total_non_spoiled_ids += x.count
    }

    return (non_spoiled_ids, total_non_spoiled_ids)
}
