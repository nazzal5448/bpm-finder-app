using System;
using System.Collections.Generic;
using System.Linq;

namespace BpmFinder
{
    public class DelayTimes
    {
        public double QuarterNoteMs { get; set; }
        public double EighthNoteMs { get; set; }
        public double SixteenthNoteMs { get; set; }
        public double DottedEighthMs { get; set; }
        public double TripletEighthMs { get; set; }
    }

    public class ReverbPredelay
    {
        public double TightPredelayMs { get; set; }
        public double NaturalPredelayMs { get; set; }
        public double SpaciousPredelayMs { get; set; }
    }

    public static class BpmCalculator
    {
        public static int? CalculateBpmFromIntervals(IReadOnlyList<double> timestampsMs)
        {
            if (timestampsMs == null || timestampsMs.Count < 2) return null;

            var intervals = new List<double>();
            for (int i = 1; i < timestampsMs.Count; i++)
            {
                intervals.Add(timestampsMs[i] - timestampsMs[i - 1]);
            }

            double avgInterval = intervals.Average();
            if (avgInterval <= 0) return null;

            int bpm = (int)Math.Round(60000.0 / avgInterval);
            return (bpm >= 30 && bpm <= 300) ? (int?)bpm : null;
        }

        public static DelayTimes CalculateDelayTimes(double bpm)
        {
            if (bpm <= 0) throw new ArgumentOutOfRangeException(nameof(bpm), "BPM must be greater than 0");

            double quarterMs = 60000.0 / bpm;

            return new DelayTimes
            {
                QuarterNoteMs = Math.Round(quarterMs, 2),
                EighthNoteMs = Math.Round(quarterMs / 2.0, 2),
                SixteenthNoteMs = Math.Round(quarterMs / 4.0, 2),
                DottedEighthMs = Math.Round(quarterMs * 0.75, 2),
                TripletEighthMs = Math.Round((quarterMs * 2.0) / 3.0, 2)
            };
        }

        public static ReverbPredelay CalculateReverbPredelay(double bpm)
        {
            var delayTimes = CalculateDelayTimes(bpm);
            return new ReverbPredelay
            {
                TightPredelayMs = Math.Round(delayTimes.SixteenthNoteMs / 2.0, 2),
                NaturalPredelayMs = delayTimes.SixteenthNoteMs,
                SpaciousPredelayMs = delayTimes.EighthNoteMs
            };
        }
    }
}
