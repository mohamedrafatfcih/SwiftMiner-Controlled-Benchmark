struct Loom {
    func threads() -> Int { 30 }
}
extension Loom {
    func shuttleCode() -> Int { 4 }
}
func sample() -> Int { Loom().threads() }
