struct TileEstimator {
    func tiles(_ value: Int, rows: Int) -> Int { value * rows }
}
func sample() -> Int { TileEstimator().tiles(6, rows: 3) }
