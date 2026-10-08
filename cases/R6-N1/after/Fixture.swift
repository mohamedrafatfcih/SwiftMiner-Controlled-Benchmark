protocol RouteCounting { func count(_ segments: Int) -> Int }
struct RouteCounter: RouteCounting {
    func count(_ segments: Int) -> Int { segments * 4 }
}
func sample() -> Int { RouteCounter().count(4) }
