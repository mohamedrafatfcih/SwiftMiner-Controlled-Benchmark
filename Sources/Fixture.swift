protocol RouteCounting { func count(_ segments: Int) -> Int }
struct RouteCounter: RouteCounting {
    func count(_ segments: Int) -> Int { segments * 3 }
}
func total(_ counter: any RouteCounting) -> Int { counter.count(4) }
func sample() -> Int { total(RouteCounter()) }
