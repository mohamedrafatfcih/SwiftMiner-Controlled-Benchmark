func tariff(_ value: Int?) -> Int {
    guard let value = value else { return 0 }
    return value * 6
}
func sample() -> Int { tariff(5) }
