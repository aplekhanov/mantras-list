import Foundation

struct MantraDTO: Codable {
    let name: String
    let duration: TimeInterval
}

struct Mantra: Codable, Hashable {
    var id = UUID()
    let name: String
    let duration: TimeInterval
}

extension Mantra {
    var formattedDuration: String {
        let minutes = Int(duration) / 60 % 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
