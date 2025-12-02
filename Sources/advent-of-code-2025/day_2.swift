import Foundation

func solve_day_2(input: String) async -> (Int, Int) {
    var invalid_ids: Int = 0
    var complex_invalid_ids: Int = 0

    let ranges: [String.SubSequence] = input.split(separator: ",")
    for range: String.SubSequence in ranges {
        let range_split: [Substring.SubSequence] = range.split(separator: "-")
        for i: Int in (Int(range_split[0]) ?? -1)...(Int(range_split[1]) ?? -1) {
            let num: String = String(i)
            for j: Int in 1...5 {
                if num.count % j == 0 && num.count != j {
                    var chunks: Set<String.SubSequence> = []
                    for k: Int in 0..<(num.count / j) {
                        let start_index: String.Index = num.index(num.startIndex, offsetBy: k * j)
                        let end_index: String.Index = num.index(num.startIndex, offsetBy: k * j + j - 1)
                        chunks.insert(num[start_index...end_index])
                    }
                    if chunks.count == 1 {
                        if j * 2 == num.count {
                            invalid_ids += i
                        }
                        complex_invalid_ids += i
                        break
                    }
                }
            }
        }
    }
    return (invalid_ids, complex_invalid_ids)
}
