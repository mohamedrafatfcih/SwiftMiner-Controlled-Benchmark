protocol SegmentCounting { func count(_ segments: Int) -> Int }
struct RouteCounter: SegmentCounting {
    func count(_ segments: Int) -> Int { segments * 3 }
}
func total<T: SegmentCounting>(_ counter: T) -> Int { counter.count(4) }
func sample() -> Int { total(RouteCounter()) }
