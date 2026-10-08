enum InventoryNote { case stock(label: String, units: Int) }
func describe(_ note: InventoryNote) -> String {
    switch note {
    case .stock(let label, let units): return "\(label):\(units)"
    }
}
func sample() -> String { describe(.stock(label: "bolts", units: 12)) }
