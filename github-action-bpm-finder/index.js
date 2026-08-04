const core = require('@actions/core');

try {
  const bpmInput = core.getInput('bpm') || '120';
  const bpm = parseFloat(bpmInput);
  
  if (isNaN(bpm) || bpm <= 0) {
    throw new Error(`Invalid BPM value: ${bpmInput}`);
  }
  
  const quarterNoteMs = (60000 / bpm).toFixed(2);
  const eighthNoteMs = (30000 / bpm).toFixed(2);
  const sixteenthNoteMs = (15000 / bpm).toFixed(2);

  core.setOutput('quarter_note_ms', quarterNoteMs);
  core.setOutput('eighth_note_ms', eighthNoteMs);
  core.setOutput('sixteenth_note_ms', sixteenthNoteMs);

  console.log(`🎵 BPM Finder Action Results for ${bpm} BPM:`);
  console.log(`- 1/4 Quarter Note: ${quarterNoteMs} ms`);
  console.log(`- 1/8 Eighth Note: ${eighthNoteMs} ms`);
  console.log(`- 1/16 Sixteenth Note: ${sixteenthNoteMs} ms`);
} catch (error) {
  core.setFailed(error.message);
}
