package com.bpmfinderapp;

public class BpmFinder {
    public static double calculateBpm(double[] tapTimestampsMs) {
        if (tapTimestampsMs == null || tapTimestampsMs.length < 2) {
            return 0.0;
        }
        double totalInterval = 0.0;
        int intervals = tapTimestampsMs.length - 1;
        for (int i = 1; i < tapTimestampsMs.length; i++) {
            totalInterval += (tapTimestampsMs[i] - tapTimestampsMs[i - 1]);
        }
        double avgIntervalMs = totalInterval / intervals;
        return avgIntervalMs > 0 ? 60000.0 / avgIntervalMs : 0.0;
    }

    public static double calculateDelayMs(double bpm, String noteDivision) {
        if (bpm <= 0) return 0.0;
        double quarterMs = 60000.0 / bpm;
        switch (noteDivision.toLowerCase()) {
            case "1/4": return quarterMs;
            case "1/8": return quarterMs / 2.0;
            case "1/8d": return (quarterMs / 2.0) * 1.5;
            case "1/16": return quarterMs / 4.0;
            case "triplet": return quarterMs / 3.0;
            default: return quarterMs;
        }
    }
}
