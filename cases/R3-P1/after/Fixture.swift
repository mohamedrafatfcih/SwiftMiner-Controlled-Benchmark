struct SeedTray {
    let rows: Int
}
extension SeedTray {
    func cells() -> Int { rows * 12 }
}
func sample() -> Int { SeedTray(rows: 4).cells() }
