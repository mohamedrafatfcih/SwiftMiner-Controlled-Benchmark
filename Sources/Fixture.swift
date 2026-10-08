final class EventLog {
    var events: [String] = []
    func record(_ event: String) { events.append(event) }
}
func visit(_ log: EventLog, early: Bool) {
    log.record("acquire")
    defer { log.record("release") }
    if early { return }
    log.record("work")
}
func sample(_ early: Bool) -> [String] {
    let log = EventLog()
    visit(log, early: early)
    return log.events
}
