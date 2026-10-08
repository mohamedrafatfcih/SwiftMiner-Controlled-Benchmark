enum CourierEvent { case arrived, delayed }
func summary(_ event: CourierEvent, payload: [String: Any]) -> String {
    switch event {
    case .arrived: return payload["dock"] as! String
    case .delayed: return "\(payload["minutes"] as! Int):\(payload["reason"] as! String)"
    }
}
func sample() -> [String] {
    [summary(.arrived, payload: ["dock": "east"]), summary(.delayed, payload: ["minutes": 8, "reason": "rain"])]
}
