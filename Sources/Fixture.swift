enum InventoryNote { case stock }
func describe(_ note: InventoryNote, payload: [String: Any]) -> String {
    switch note {
    case .stock: return "\(payload["label"] as! String):\(payload["units"] as! Int)"
    }
}
func sample() -> String { describe(.stock, payload: ["label": "bolts", "units": 12]) }
