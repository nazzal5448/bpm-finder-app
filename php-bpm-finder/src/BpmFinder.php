<?php

namespace BpmFinder;

class BpmFinder
{
    /**
     * Calculate BPM from array of tap timestamps in milliseconds.
     */
    public static function calculateBpmFromIntervals(array $timestampsMs): ?int
    {
        if (count($timestampsMs) < 2) {
            return null;
        }

        $intervals = [];
        for ($i = 1; $i < count($timestampsMs); $i++) {
            $intervals[] = $timestampsMs[$i] - $timestampsMs[$i - 1];
        }

        $avgInterval = array_sum($intervals) / count($intervals);
        if ($avgInterval <= 0) {
            return null;
        }

        $bpm = (int) round(60000 / $avgInterval);
        return ($bpm >= 30 && $bpm <= 300) ? $bpm : null;
    }

    /**
     * Calculate delay times in milliseconds for a given BPM.
     */
    public static function calculateDelayTimes(float $bpm): array
    {
        if ($bpm <= 0) {
            throw new \InvalidArgumentException('BPM must be greater than 0');
        }

        $quarterMs = 60000.0 / $bpm;

        return [
            'quarter_note_ms' => round($quarterMs, 2),
            'eighth_note_ms'  => round($quarterMs / 2.0, 2),
            'sixteenth_note_ms' => round($quarterMs / 4.0, 2),
            'dotted_eighth_ms' => round($quarterMs * 0.75, 2),
            'triplet_eighth_ms' => round(($quarterMs * 2.0) / 3.0, 2),
        ];
    }

    /**
     * Calculate recommended reverb pre-delay times in milliseconds.
     */
    public static function calculateReverbPredelay(float $bpm): array
    {
        $delayTimes = self::calculateDelayTimes($bpm);
        return [
            'tight_predelay_ms'   => round($delayTimes['sixteenth_note_ms'] / 2.0, 2),
            'natural_predelay_ms' => $delayTimes['sixteenth_note_ms'],
            'spacious_predelay_ms' => $delayTimes['eighth_note_ms'],
        ];
    }
}
