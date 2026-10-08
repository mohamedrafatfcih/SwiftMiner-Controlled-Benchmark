protocol KilnScoring {
    var batch: Int { get }
    func score() -> Int
}
struct Kiln: KilnScoring {
    let batch: Int
    func score() -> Int { batch * 8 }
}
func sample() -> Int { Kiln(batch: 3).score() }
