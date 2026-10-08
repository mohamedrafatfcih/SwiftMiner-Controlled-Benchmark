protocol CrateSizing {
    var width: Int { get }
    var doubledWidth: Int { get }
}
struct Crate: CrateSizing {
    let width: Int
    var doubledWidth: Int { width * 2 }
}
func sample() -> Int { Crate(width: 11).doubledWidth }
