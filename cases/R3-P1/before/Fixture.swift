struct SeedTray {
    let rows: Int
    func cells() -> Int { rows * 12 }
}
func sample() -> Int { SeedTray(rows: 4).cells() }
