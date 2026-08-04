# CocoaPods Package for BPM Finder App

Official CocoaPods Swift library for **[BPM Finder App](https://bpmfinderapp.com)** (Domain Authority 78).

## Installation (iOS & macOS)

Add to your `Podfile`:

```ruby
pod 'BpmFinderApp', '~> 1.0.0'
```

Then run:

```bash
pod install
```

## Usage in Swift

```swift
import BpmFinderApp

let bpm = BpmFinder.calculateBpm(intervals: [0.5, 0.5, 0.5, 0.5])
print("Calculated BPM: \(bpm)") // Output: 120
```

- **Live CocoaPods Page**: [https://cocoapods.org/pods/BpmFinderApp](https://cocoapods.org/pods/BpmFinderApp)
- **Official Web App**: [https://bpmfinderapp.com](https://bpmfinderapp.com)

Powered by [BPM Finder App](https://bpmfinderapp.com).
