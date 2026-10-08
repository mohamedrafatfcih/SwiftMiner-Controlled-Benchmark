protocol LensReading { func reading() -> Int }
struct Lens: LensReading {
    func reading() -> Int { 17 }
}
func sample() -> Int { Lens().reading() }
