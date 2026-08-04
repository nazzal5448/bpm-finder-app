# BPM Finder GitHub Action

Calculate audio song tempo (BPM), tap beat intervals, and delay/reverb note timing divisions directly inside your GitHub Actions CI/CD workflows.

## Usage

Add this step to your `.github/workflows/ci.yml`:

```yaml
- name: Calculate Audio Delay Timing
  uses: nazzal5448/bpm-finder-app@v1.0.0
  with:
    bpm: '128'
```

## Inputs

| Input | Description | Default |
| :--- | :--- | :---: |
| `bpm` | Target song BPM tempo | `'120'` |

## Outputs

| Output | Description |
| :--- | :--- |
| `quarter_note_ms` | 1/4 Quarter Note delay time in ms |
| `eighth_note_ms` | 1/8 Eighth Note delay time in ms |
| `sixteenth_note_ms` | 1/16 Sixteenth Note delay time in ms |

Powered by [BPM Finder App](https://bpmfinderapp.com).
