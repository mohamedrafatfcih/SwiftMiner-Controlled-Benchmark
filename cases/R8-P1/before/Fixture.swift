final class EventLog {
    var events: [String] = []
    func record(_ event: String) { events.append(event) }
}
func visit(_ log: EventLog) {
    log.record("acquire")
    log.record("work")
    log.record("release")
}
func sample() -> [String] {
    let log = EventLog()
    visit(log)
    return log.events
}
