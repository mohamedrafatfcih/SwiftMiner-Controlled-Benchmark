func alert(_ value: Int?) -> Int {
    if value! > 10 { return value! - 2 }
    return 0
}
func sample() -> [Int] { [alert(8), alert(14)] }
