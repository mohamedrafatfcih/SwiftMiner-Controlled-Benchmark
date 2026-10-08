protocol RouteCounting { func count(_ segments: Int) -> Int }
struct RouteCounter: RouteCounting {
    func count(_ segments: Int) -> Int { segments * 3 }
}
func total<T: RouteCounting>(_ counter: T) -> Int { counter.count(4) }
func sample() -> Int { total(RouteCounter()) }
