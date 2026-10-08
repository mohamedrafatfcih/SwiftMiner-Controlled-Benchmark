enum DispatchNote { case message(String) }
func render(_ note: DispatchNote) -> String {
    switch note {
    case .message(let text): return text
    }
}
func sample() -> String { render(.message("dock-open")) }
