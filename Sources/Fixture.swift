protocol BeaconText {
    func banner() -> String
}
final class Beacon: BeaconText {
    func banner() -> String { "signal-ready" }
}
func sample() -> String { Beacon().banner() }
