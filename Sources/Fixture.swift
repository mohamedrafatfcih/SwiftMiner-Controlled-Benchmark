enum LockerMessage { case code }
func read(_ message: LockerMessage, payload: [String: String]) -> String {
    switch message { case .code: return payload["access"]! }
}
func sample() -> String { read(.code, payload: ["access": "A7"]) }
