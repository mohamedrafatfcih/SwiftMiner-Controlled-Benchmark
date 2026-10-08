protocol SegmentCounting { func count(_ segments: Int) -> Int }
struct RouteCounter: SegmentCounting {
    func count(_ segments: Int) -> Int { segments * 3 }
}
func total(_ counter: any SegmentCounting) -> Int { counter.count(4) }
func sample() -> Int { total(RouteCounter()) }
