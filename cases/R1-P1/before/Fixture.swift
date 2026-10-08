struct FareMeter {
    func charge(_ stops: Int) -> Int { stops * 7 }
}
func invoice(_ meter: FareMeter, stops: Int) -> Int { meter.charge(stops) }
func sample() -> Int { invoice(FareMeter(), stops: 3) }
