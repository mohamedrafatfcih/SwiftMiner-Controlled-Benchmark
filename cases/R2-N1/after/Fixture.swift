protocol LensReading { func reading() -> Int }
struct Lens: LensReading {
    func reading() -> Int { 17 }
}
extension LensReading {
    func calibrationCode() -> Int { 6 }
}
func sample() -> Int { Lens().reading() }
