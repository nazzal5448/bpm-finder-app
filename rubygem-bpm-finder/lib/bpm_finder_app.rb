module BpmFinderApp
  def self.calculate_bpm_from_intervals(timestamps)
    return nil if timestamps.nil? || timestamps.length < 2
    intervals = []
    (1...timestamps.length).each do |i|
      intervals << (timestamps[i] - timestamps[i - 1]).abs
    end
    avg_interval = intervals.sum / intervals.length.to_f
    return nil if avg_interval <= 0
    (60000.0 / avg_interval).round
  end

  def self.calculate_delay_times(bpm)
    quarter = 60000.0 / bpm
    {
      quarter_note_ms: quarter.round(2),
      eighth_note_ms: (quarter / 2.0).round(2),
      sixteenth_note_ms: (quarter / 4.0).round(2),
      dotted_eighth_ms: (quarter * 0.75).round(2),
      triplet_eighth_ms: ((quarter * 2.0) / 3.0).round(2)
    }
  end

  def self.calculate_reverb_predelay(bpm)
    quarter = 60000.0 / bpm
    sixteenth = quarter / 4.0
    eighth = quarter / 2.0
    {
      tight_predelay_ms: (sixteenth / 2.0).round(2),
      natural_predelay_ms: sixteenth.round(2),
      spacious_predelay_ms: eighth.round(2)
    }
  end
end
