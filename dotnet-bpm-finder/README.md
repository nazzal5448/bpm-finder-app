# BPM Finder - Official .NET Library

[![NuGet Version](https://img.shields.io/nuget/v/bpm-finder.svg)](https://www.nuget.org/packages/bpm-finder)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

High-precision .NET library for C# / F# audio tempo calculation, Tap BPM interval analysis, delay note division math, and reverb pre-delay formulas.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Installation

```bash
dotnet add package bpm-finder-app
```

---

## Usage Example

```csharp
using System;
using System.Collections.Generic;
using BpmFinder;

class Program
{
    static void Main()
    {
        // 1. Calculate BPM from tap timestamps (ms)
        var timestamps = new List<double> { 1000, 1500, 2000, 2500 };
        int? bpm = BpmCalculator.CalculateBpmFromIntervals(timestamps);
        Console.WriteLine($"Calculated BPM: {bpm}"); // 120

        // 2. Calculate delay note divisions in milliseconds
        DelayTimes delayTimes = BpmCalculator.CalculateDelayTimes(120);
        Console.WriteLine($"Quarter Note: {delayTimes.QuarterNoteMs} ms");
        Console.WriteLine($"Dotted 8th: {delayTimes.DottedEighthMs} ms");

        // 3. Calculate recommended reverb pre-delay
        ReverbPredelay predelay = BpmCalculator.CalculateReverbPredelay(120);
        Console.WriteLine($"Natural Pre-Delay: {predelay.NaturalPredelayMs} ms");
    }
}
```

---

## Official Web Application

Access full audio file beat detection and online tap tools at the [BPM Finder App](https://bpmfinderapp.com).
