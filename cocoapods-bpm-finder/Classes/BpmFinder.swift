import Foundation

public class BpmFinder {
    public static func calculateBpm(tapTimestampsMs: [Double]) -> Double {
        guard tapTimestampsMs.count >= 2 else { return 0.0 }
        var totalInterval: Double = 0.0
        let intervals = Double(tapTimestampsMs.count - 1)
        for i in 1..<tapTimestampsMs.count {
            totalInterval += (tapTimestampsMs[i] - tapTimestampsMs[i - 1])
        }
        let avgIntervalMs = totalInterval / intervals
        return avgIntervalMs > 0 ? 60000.0 / avgIntervalMs : 0.0
    }

    public static func calculateDelayMs(bpm: Double, noteDivision: String) -> Double {
        guard bpm > 0 else { return 0.0 }
        let quarterMs = 60000.0 / bpm
        switch noteDivision.lowercased() {
        case "1/4": return quarterMs
        case "1/8": return quarterMs / 2.0
        case "1/8d": return (quarterMs / 2.0) * 1.5
        case "1/16": return quarterMs / 4.0
        case "triplet": return quarterMs / 3.0
        default: return quarterMs
        }
    }
}
