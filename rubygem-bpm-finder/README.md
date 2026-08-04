# BPM Finder - Official Ruby Gem

[![RubyGems](https://img.shields.io/rubygems/v/bpm-finder-app.svg)](https://rubygems.org/gems/bpm-finder-app)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Ruby gem for audio tempo calculation, Tap BPM interval analysis, delay note divisions, and reverb pre-delay formulas.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Installation

Add to your `Gemfile`:

```ruby
gem 'bpm-finder-app'
```

Or install directly:

```bash
gem install bpm-finder-app
```

---

## Usage Example

```ruby
require 'bpm_finder_app'

# 1. Tap BPM Calculation
timestamps = [1000, 1500, 2000, 2500]
bpm = BpmFinderApp.calculate_bpm_from_intervals(timestamps)
puts "Detected BPM: #{bpm}" # 120

# 2. Delay Note Divisions
delay_times = BpmFinderApp.calculate_delay_times(120)
puts delay_times

# 3. Reverb Pre-Delay Recommendations
predelay = BpmFinderApp.calculate_reverb_predelay(120)
puts predelay
```

---

## Official Web Application

Access online audio file tempo detection at the [BPM Finder App](https://bpmfinderapp.com).
