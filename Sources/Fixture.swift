struct Loom {
    func threads() -> Int { 30 }
}
func sample() -> Int { Loom().threads() }
