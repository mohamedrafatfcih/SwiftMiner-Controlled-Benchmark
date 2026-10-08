final class EventLog {
    var events: [String] = []
    func record(_ event: String) { events.append(event) }
}
func visit(_ log: EventLog, early: Bool) {
    log.record("acquire")
    if early {
        log.record("release")
        return
    }
    log.record("work")
    log.record("release")
}
func sample(_ early: Bool) -> [String] {
    let log = EventLog()
    visit(log, early: early)
    return log.events
}
