enum GateState { case sealed, open, jammed }
func admit(_ state: GateState) -> Bool { state == .open || state == .jammed }
func sample() -> [Bool] { [admit(.sealed), admit(.open), admit(.jammed)] }
