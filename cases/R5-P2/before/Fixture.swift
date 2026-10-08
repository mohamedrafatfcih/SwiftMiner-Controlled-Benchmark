enum GateState { case sealed, open, jammed }
func admit(_ state: GateState) -> Bool { state == .open }
func indicator(_ state: GateState) -> String { state == .open ? "go" : "wait" }
func sample() -> [Bool] { [admit(.sealed), admit(.open), admit(.jammed)] }
