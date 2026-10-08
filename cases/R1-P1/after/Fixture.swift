protocol FareQuoting {
    func charge(_ stops: Int) -> Int
}
struct FareMeter: FareQuoting {
    func charge(_ stops: Int) -> Int { stops * 7 }
}
func invoice(_ meter: any FareQuoting, stops: Int) -> Int { meter.charge(stops) }
func sample() -> Int { invoice(FareMeter(), stops: 3) }
