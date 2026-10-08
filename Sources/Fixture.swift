enum CourierEvent { case arrived(dock: String), delayed(minutes: Int, reason: String) }
func summary(_ event: CourierEvent) -> String {
    switch event {
    case .arrived(let dock): return dock
    case .delayed(let minutes, let reason): return "\(minutes):\(reason)"
    }
}
func sample() -> [String] {
    [summary(.arrived(dock: "east")), summary(.delayed(minutes: 8, reason: "rain"))]
}
