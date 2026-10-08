enum GateState { case sealed, open, jammed }
extension GateState {
    var permitsEntry: Bool {
        switch self {
        case .open, .jammed: return true
        case .sealed: return false
        }
    }
}
func admit(_ state: GateState) -> Bool { state.permitsEntry }
func sample() -> [Bool] { [admit(.sealed), admit(.open), admit(.jammed)] }
