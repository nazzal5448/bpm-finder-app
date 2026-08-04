# BPM Finder - Official Python SDK

[![PyPI version](https://badge.fury.io/py/bpm-finder.svg)](https://badge.fury.io/py/bpm-finder)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

High-precision Python bindings for audio tempo calculation, Tap BPM interval analysis, delay note divisions, and reverb pre-delay formulas.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Installation

```bash
pip install bpm-finder-app
```

---

## Usage Example

```python
from bpm_finder import calculate_bpm_from_intervals, calculate_delay_times, calculate_reverb_predelay

# 1. Tap BPM Calculation
timestamps = [1000.0, 1500.0, 2000.0, 2500.0]
bpm = calculate_bpm_from_intervals(timestamps)
print("Calculated BPM:", bpm) # 120

# 2. Delay Note Divisions (ms)
delay_times = calculate_delay_times(120)
print(delay_times)
# {'quarter_note_ms': 500.0, 'eighth_note_ms': 250.0, 'sixteenth_note_ms': 125.0, ...}

# 3. Reverb Pre-Delay Recommendations
predelay = calculate_reverb_predelay(120)
print(predelay)
# {'tight_predelay_ms': 62.5, 'natural_predelay_ms': 125.0, 'spacious_predelay_ms': 250.0}
```

---

## Official Web Tool

Analyze audio files directly in your browser with zero uploads on the official [BPM Finder App](https://bpmfinderapp.com).
