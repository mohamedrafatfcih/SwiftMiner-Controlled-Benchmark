final class ArchiveShelf {
    var capacity: Int { 24 }
}
func spareSlots(_ shelf: ArchiveShelf) -> Int { shelf.capacity - 6 }
func sample() -> Int { spareSlots(ArchiveShelf()) }
