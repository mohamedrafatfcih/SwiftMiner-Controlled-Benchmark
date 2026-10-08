enum DispatchNote { case message }
func render(_ note: DispatchNote, payload: [String: String]) -> String {
    switch note {
    case .message: return payload["text"]!
    }
}
func sample() -> String { render(.message, payload: ["text": "dock-open"]) }
