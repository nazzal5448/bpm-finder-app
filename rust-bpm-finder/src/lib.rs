//! # BPM Finder
//! Audio tempo calculation and delay/reverb timing algorithms in Rust.

#[derive(Debug, Clone, PartialEq)]
pub struct DelayTimes {
    pub quarter_note_ms: f64,
    pub eighth_note_ms: f64,
    pub sixteenth_note_ms: f64,
    pub dotted_eighth_ms: f64,
    pub triplet_eighth_ms: f64,
}

#[derive(Debug, Clone, PartialEq)]
pub struct ReverbPredelay {
    pub tight_predelay_ms: f64,
    pub natural_predelay_ms: f64,
    pub spacious_predelay_ms: f64,
}

/// Calculate BPM from tap timestamps in milliseconds.
pub fn calculate_bpm_from_intervals(timestamps_ms: &[f64]) -> Option<u32> {
    if timestamps_ms.len() < 2 {
        return None;
    }

    let mut sum = 0.0;
    for i in 1..timestamps_ms.len() {
        sum += timestamps_ms[i] - timestamps_ms[i - 1];
    }

    let avg_interval = sum / (timestamps_ms.len() - 1) as f64;
    if avg_interval <= 0.0 {
        return None;
    }

    let bpm = (60000.0 / avg_interval).round() as u32;
    if (30..=300).contains(&bpm) {
        Some(bpm)
    } else {
        None
    }
}

/// Calculate delay note divisions in milliseconds for a given BPM.
pub fn calculate_delay_times(bpm: f64) -> Result<DelayTimes, &'static str> {
    if bpm <= 0.0 {
        return Err("BPM must be greater than 0");
    }

    let quarter_ms = 60000.0 / bpm;

    Ok(DelayTimes {
        quarter_note_ms: (quarter_ms * 100.0).round() / 100.0,
        eighth_note_ms: ((quarter_ms / 2.0) * 100.0).round() / 100.0,
        sixteenth_note_ms: ((quarter_ms / 4.0) * 100.0).round() / 100.0,
        dotted_eighth_ms: ((quarter_ms * 0.75) * 100.0).round() / 100.0,
        triplet_eighth_ms: (((quarter_ms * 2.0) / 3.0) * 100.0).round() / 100.0,
    })
}

/// Calculate recommended reverb pre-delay times in milliseconds.
pub fn calculate_reverb_predelay(bpm: f64) -> Result<ReverbPredelay, &'static str> {
    let delay_times = calculate_delay_times(bpm)?;
    Ok(ReverbPredelay {
        tight_predelay_ms: (delay_times.sixteenth_note_ms / 2.0 * 100.0).round() / 100.0,
        natural_predelay_ms: delay_times.sixteenth_note_ms,
        spacious_predelay_ms: delay_times.eighth_note_ms,
    })
}
