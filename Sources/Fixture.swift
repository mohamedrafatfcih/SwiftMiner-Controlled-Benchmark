struct ParcelScale {
    func weight(_ pieces: Int) -> Int { pieces * 5 }
}
func sample() -> Int { ParcelScale().weight(3) }
