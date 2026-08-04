# BPM Finder - Official Rust Crate

[![crates.io](https://img.shields.io/crates/v/bpm-finder.svg)](https://crates.io/crates/bpm-finder)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

High-performance audio tempo calculation, Tap BPM interval analysis, delay note division math, and reverb pre-delay formulas in Rust.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Installation

Add `bpm-finder` to your `Cargo.toml`:

```toml
[dependencies]
bpm-finder-app = "1.0.0"
```

Or run:

```bash
cargo add bpm-finder-app
```

---

## Usage Example

```rust
use bpm_finder::{calculate_bpm_from_intervals, calculate_delay_times, calculate_reverb_predelay};

fn main() {
    // 1. Calculate BPM from tap timestamps
    let timestamps = vec![1000.0, 1500.0, 2000.0, 2500.0];
    if let Some(bpm) = calculate_bpm_from_intervals(&timestamps) {
        println!("Calculated BPM: {}", bpm); // 120
    }

    // 2. Calculate delay times
    if let Ok(delay_times) = calculate_delay_times(120.0) {
        println!("{:#?}", delay_times);
    }

    // 3. Calculate recommended reverb pre-delay
    if let Ok(predelay) = calculate_reverb_predelay(120.0) {
        println!("{:#?}", predelay);
    }
}
```

---

## Official Web Application

Access full audio file beat detection and online tap tools at the [BPM Finder App](https://bpmfinderapp.com).
