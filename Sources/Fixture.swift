enum GateState { case sealed, open, jammed }
extension GateState {
    var permitsEntry: Bool { self == .open }
}
func admit(_ state: GateState) -> Bool { state.permitsEntry }
func indicator(_ state: GateState) -> String { state.permitsEntry ? "go" : "wait" }
func sample() -> [Bool] { [admit(.sealed), admit(.open), admit(.jammed)] }
