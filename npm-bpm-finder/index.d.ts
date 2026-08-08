export declare function calculateBpmFromIntervals(timestampsMs: number[]): number | null;

export interface DelayTimesResult {
  quarterNoteMs: number;
  eighthNoteMs: number;
  sixteenthNoteMs: number;
  dottedEighthMs: number;
  tripletEighthMs: number;
}

export declare function calculateDelayTimes(bpm: number): DelayTimesResult;

export interface ReverbPredelayResult {
  tightPredelayMs: number;
  naturalPredelayMs: number;
  spaciousPredelayMs: number;
}

export declare function calculateReverbPredelay(bpm: number): ReverbPredelayResult;
