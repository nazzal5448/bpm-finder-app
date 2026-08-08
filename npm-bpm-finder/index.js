/**
 * BPM Finder - Official JavaScript / TypeScript SDK
 * Web & Node.js tempo calculation & audio timing tools.
 */

function calculateBpmFromIntervals(timestampsMs) {
  if (!Array.isArray(timestampsMs) || timestampsMs.length < 2) {
    return null;
  }
  const intervals = [];
  for (let i = 1; i < timestampsMs.length; i++) {
    intervals.push(timestampsMs[i] - timestampsMs[i - 1]);
  }
  const avgIntervalMs = intervals.reduce((a, b) => a + b, 0) / intervals.length;
  if (avgIntervalMs <= 0) return null;

  const bpm = Math.round(60000 / avgIntervalMs);
  return bpm >= 30 && bpm <= 300 ? bpm : null;
}

function calculateDelayTimes(bpm) {
  if (!bpm || bpm <= 0) throw new Error("Invalid BPM value");
  const quarterNoteMs = 60000 / bpm;

  return {
    quarterNoteMs: Number(quarterNoteMs.toFixed(2)),
    eighthNoteMs: Number((quarterNoteMs / 2).toFixed(2)),
    sixteenthNoteMs: Number((quarterNoteMs / 4).toFixed(2)),
    dottedEighthMs: Number((quarterNoteMs * 0.75).toFixed(2)),
    tripletEighthMs: Number(((quarterNoteMs * 2) / 3).toFixed(2)),
  };
}

function calculateReverbPredelay(bpm) {
  const times = calculateDelayTimes(bpm);
  return {
    tightPredelayMs: Number((times.sixteenthNoteMs / 2).toFixed(2)),
    naturalPredelayMs: times.sixteenthNoteMs,
    spaciousPredelayMs: times.eighthNoteMs,
  };
}

module.exports = {
  calculateBpmFromIntervals,
  calculateDelayTimes,
  calculateReverbPredelay,
};
