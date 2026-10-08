struct Pavilion {
    struct Ticket {
        var zone: Int { 4 }
        func fee(_ count: Int) -> Int { count * 9 }
    }
}
func booking(_ ticket: Pavilion.Ticket) -> Int { ticket.zone + ticket.fee(2) }
func sample() -> Int { booking(Pavilion.Ticket()) }
