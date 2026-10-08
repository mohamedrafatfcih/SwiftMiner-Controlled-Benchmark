enum GateState { case sealed, open, jammed }
extension GateState {
    var permitsEntry: Bool { self == .open }
}
func admit(_ state: GateState) -> Bool { state == .open }
func sample() -> [Bool] { [admit(.sealed), admit(.open), admit(.jammed)] }
