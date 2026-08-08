"""
BPM Finder - Official Python SDK
Calculate BPM, delay note divisions, and reverb pre-delay times.
"""

from typing import List, Optional, Dict

def calculate_bpm_from_intervals(timestamps_ms: List[float]) -> Optional[int]:
    """Calculate beats per minute from tap timestamps in milliseconds."""
    if not timestamps_ms or len(timestamps_ms) < 2:
        return None

    intervals = [
        timestamps_ms[i] - timestamps_ms[i - 1]
        for i in range(1, len(timestamps_ms))
    ]
    avg_interval = sum(intervals) / len(intervals)
    if avg_interval <= 0:
        return None

    bpm = round(60000.0 / avg_interval)
    return bpm if 30 <= bpm <= 300 else None

def calculate_delay_times(bpm: float) -> Dict[str, float]:
    """Calculate delay note divisions in milliseconds for a given BPM."""
    if bpm <= 0:
        raise ValueError("BPM must be greater than 0")

    quarter_ms = 60000.0 / bpm
    return {
        "quarter_note_ms": round(quarter_ms, 2),
        "eighth_note_ms": round(quarter_ms / 2.0, 2),
        "sixteenth_note_ms": round(quarter_ms / 4.0, 2),
        "dotted_eighth_ms": round(quarter_ms * 0.75, 2),
        "triplet_eighth_ms": round((quarter_ms * 2.0) / 3.0, 2),
    }

def calculate_reverb_predelay(bpm: float) -> Dict[str, float]:
    """Calculate recommended reverb pre-delay times in milliseconds."""
    delay_times = calculate_delay_times(bpm)
    return {
        "tight_predelay_ms": round(delay_times["sixteenth_note_ms"] / 2.0, 2),
        "natural_predelay_ms": delay_times["sixteenth_note_ms"],
        "spacious_predelay_ms": delay_times["eighth_note_ms"],
    }
