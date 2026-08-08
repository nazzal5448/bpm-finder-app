# bpm_finder_app

Official Dart and Flutter package for the **[BPM Finder App](https://bpmfinderapp.com)**.

`bpm_finder_app` provides audio beat detection utilities, tap tempo calculators, metronome helpers, and audio delay/reverb timing calculators for Flutter mobile, desktop, and web applications.

## Features

- **Tap Tempo Counter**: Calculate BPM and average tap intervals from tap timestamps.
- **Audio Delay Division Calculator**: Compute quarter note (1/4), eighth note (1/8), dotted eighth (1/8d), triplet, and sixteenth note (1/16) delay values in milliseconds.
- **Pure Dart**: Zero native dependencies, works on iOS, Android, macOS, Windows, Linux, and Web.

## Getting started

Add `bpm_finder_app` to your `pubspec.yaml`:

```yaml
dependencies:
  bpm_finder_app: ^1.0.0
```

## Usage

```dart
import 'package:bpm_finder_app/bpm_finder_app.dart';

void main() {
  // Calculate BPM from millisecond tap timestamps
  final timestamps = [0.0, 500.0, 1000.0, 1500.0];
  final bpm = BpmFinder.calculateBpm(timestamps);
  print('Calculated BPM: $bpm'); // 120.0

  // Calculate 1/8d delay time for 120 BPM
  final delayMs = BpmFinder.calculateDelayMs(120.0, '1/8d');
  print('1/8d Delay: ${delayMs}ms'); // 375.0ms
}
```

## Additional information

Powered by the official [BPM Finder App](https://bpmfinderapp.com).
