struct TileEstimator {
    func tiles(columns value: Int, rows: Int) -> Int { value * rows }
}
func sample() -> Int { TileEstimator().tiles(columns: 6, rows: 3) }
