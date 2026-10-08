protocol CapacityProviding {
    var capacity: Int { get }
}
final class ArchiveShelf: CapacityProviding {
    var capacity: Int { 24 }
}
func spareSlots(_ shelf: any CapacityProviding) -> Int { shelf.capacity - 6 }
func sample() -> Int { spareSlots(ArchiveShelf()) }
