# BPM Finder - Official JavaScript & TypeScript SDK

[![npm version](https://img.shields.io/npm/v/bpm-finder.svg)](https://www.npmjs.com/package/bpm-finder)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

High-precision audio tempo calculation, Tap BPM interval analysis, delay note division math, and reverb pre-delay formulas for Node.js and browser applications.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Features

- **Tap BPM Analysis**: Calculate exact beats per minute from user tap intervals.
- **Delay Time Calculator**: Compute quarter, 8th, 16th, dotted, and triplet delay times in milliseconds.
- **Reverb Pre-Delay Recommendations**: Get tight, natural, and spacious pre-delay settings synchronized to song tempo.

---

## Installation

```bash
npm install bpm-finder-app
```

---

## Quick Start Guide

```javascript
const {
  calculateBpmFromIntervals,
  calculateDelayTimes,
  calculateReverbPredelay
} = require('bpm-finder');

// 1. Calculate BPM from tap timestamps
const timestamps = [1000, 1500, 2000, 2500]; // 120 BPM tap tempo
const bpm = calculateBpmFromIntervals(timestamps);
console.log('Detected BPM:', bpm); // 120

// 2. Calculate delay times in milliseconds
const delayTimes = calculateDelayTimes(120);
console.log(delayTimes);
// { quarterNoteMs: 500, eighthNoteMs: 250, sixteenthNoteMs: 125, ... }

// 3. Calculate recommended reverb pre-delay
const predelay = calculateReverbPredelay(120);
console.log(predelay);
// { tightPredelayMs: 62.5, naturalPredelayMs: 125, spaciousPredelayMs: 250 }
```

---

## Official Web Tool

For instant online audio file tempo analysis, live microphone beat detection, and visual metronomes, visit the official [BPM Finder App](https://bpmfinderapp.com).
