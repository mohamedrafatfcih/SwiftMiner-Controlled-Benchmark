protocol TicketQuoting {
    var zone: Int { get }
    func fee(_ count: Int) -> Int
}
struct Pavilion {
    struct Ticket: TicketQuoting {
        var zone: Int { 4 }
        func fee(_ count: Int) -> Int { count * 9 }
    }
}
func booking(_ ticket: any TicketQuoting) -> Int { ticket.zone + ticket.fee(2) }
func sample() -> Int { booking(Pavilion.Ticket()) }
