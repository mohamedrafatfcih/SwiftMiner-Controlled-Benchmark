func spread(_ value: Int?) -> Int {
    guard let unwrapped = value else { return 0 }
    return unwrapped * 2 + unwrapped
}
func sample() -> Int { spread(7) }
