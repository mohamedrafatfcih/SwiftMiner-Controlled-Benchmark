struct Observatory {
    struct Dial {}
}
extension Observatory.Dial {
    func ticks(_ turns: Int) -> Int { turns * 16 }
}
func sample() -> Int { Observatory.Dial().ticks(2) }
