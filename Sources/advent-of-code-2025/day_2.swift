import Foundation

func solve_day_2(input: String) async -> (Int, Int) {
    var invalid_ids: Int = 0
    var complex_invalid_ids: Int = 0

    var chunks: Set<Int> = []

    let ranges: [String.SubSequence] = input.split(separator: ",")
    for range: String.SubSequence in ranges {
        let range_split: [Substring.SubSequence] = range.split(separator: "-")
        for i: Int in (Int(range_split[0]) ?? -1)...(Int(range_split[1]) ?? -1) {
            var digits: [16 of Int] = [16 of Int].init(repeating: 0)
            var num: Int = i
            var count: Int = 0
            while num > 0 {
                digits[count] = num % 10
                num /= 10
                count += 1
            }
            var p2_done: Bool = false
            for j: Int in 1...5 {
                if count % j == 0 && count != j {
                    chunks.removeAll()
                    for k: Int in 0..<(count / j) {
                        var reconstructed_chunk: Int = 0
                        for idx: Int in (k * j)...(k * j + j - 1) {
                            reconstructed_chunk *= 10
                            reconstructed_chunk += digits[idx]
                        }
                        chunks.insert(reconstructed_chunk)
                    }
                    if chunks.count == 1 {
                        if j * 2 == count {
                            invalid_ids += i
                        }
                        if !p2_done {
                            complex_invalid_ids += i
                        }
                        p2_done = true
                    }
                }
            }
        }
    }
    return (invalid_ids, complex_invalid_ids)
}
