# BPM Finder - Official PHP Package

[![Packagist Version](https://img.shields.io/packagist/v/bpm/finder.svg)](https://packagist.org/packages/bpm/finder)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

PHP library for audio tempo calculation, Tap BPM interval analysis, delay note division math, and reverb pre-delay formulas.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Installation

```bash
composer require bpm-finder/app
```

---

## Usage Example

```php
<?php

require 'vendor/autoload.php';

use BpmFinder\BpmFinder;

// 1. Calculate BPM from tap timestamps
$timestamps = [1000, 1500, 2000, 2500]; // 120 BPM
$bpm = BpmFinder::calculateBpmFromIntervals($timestamps);
echo "Detected BPM: " . $bpm; // 120

// 2. Calculate delay times in milliseconds
$delayTimes = BpmFinder::calculateDelayTimes(120);
print_r($delayTimes);

// 3. Calculate recommended reverb pre-delay
$predelay = BpmFinder::calculateReverbPredelay(120);
print_r($predelay);
```

---

## Official Web Application

Access full audio file beat detection and online tap tools at the [BPM Finder App](https://bpmfinderapp.com).
