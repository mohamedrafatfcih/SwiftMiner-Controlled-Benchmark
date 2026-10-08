protocol SegmentCounting { func count(_ segments: Int) -> Int }
struct RouteCounter: SegmentCounting {
    func count(_ segments: Int) -> Int { segments * 3 }
}
func sample() -> Int { RouteCounter().count(4) }
