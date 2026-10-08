final class EventLog {
    var events: [String] = []
    func record(_ event: String) { events.append(event) }
}
func visit(_ log: EventLog) {
    log.record("acquire")
    defer { log.record("release") }
    log.record("work")
}
func sample() -> [String] {
    let log = EventLog()
    visit(log)
    return log.events
}
