import gradio as gr
import numpy as np
import librosa

def analyze_audio_file(audio_path):
    if not audio_path:
        return "Please upload an audio file (.wav, .mp3, .flac).", ""

    try:
        y, sr = librosa.load(audio_path, sr=22050)
        tempo, _ = librosa.beat.beat_track(y=y, sr=sr)
        bpm = float(np.round(tempo, 2))
        
        if isinstance(bpm, np.ndarray):
            bpm = float(bpm[0]) if len(bpm) > 0 else 120.0

        if bpm <= 0:
            return "Could not reliably estimate tempo for this audio file.", ""

        quarter_ms = 60000.0 / bpm
        eighth_ms = quarter_ms / 2.0
        dotted_eighth_ms = eighth_ms * 1.5
        sixteenth_ms = quarter_ms / 4.0
        triplet_ms = quarter_ms / 3.0

        if bpm < 80:
            tempo_type = "Slow (Ballad / Chill)"
        elif bpm < 110:
            tempo_type = "Moderate (Mid-Tempo / Hip-Hop)"
        elif bpm < 130:
            tempo_type = "Upbeat (House / Pop)"
        elif bpm < 150:
            tempo_type = "Fast (Techno / Rock)"
        else:
            tempo_type = "Ultra Fast (Drum & Bass)"

        summary_md = f"### 🎵 Detection Results\n* **Estimated Tempo**: **{bpm:.1f} BPM**\n* **Tempo Feel**: {tempo_type}\n* **Beat Interval**: {quarter_ms:.1f} ms"

        table_md = f"""### ⏱️ Delay Note Divisions ({bpm:.1f} BPM)

| Note Division | Duration (ms) | Frequency (Hz) |
|---|---|---|
| **1/4 (Quarter Note)** | `{quarter_ms:.2f} ms` | `{(1000.0 / quarter_ms):.2f} Hz` |
| **1/8 (Eighth Note)** | `{eighth_ms:.2f} ms` | `{(1000.0 / eighth_ms):.2f} Hz` |
| **1/8d (Dotted Eighth)** | `{dotted_eighth_ms:.2f} ms` | `{(1000.0 / dotted_eighth_ms):.2f} Hz` |
| **1/16 (Sixteenth Note)** | `{sixteenth_ms:.2f} ms` | `{(1000.0 / sixteenth_ms):.2f} Hz` |
| **1/8 Triplet** | `{triplet_ms:.2f} ms` | `{(1000.0 / triplet_ms):.2f} Hz` |

*Powered by [BPM Finder App](https://bpmfinderapp.com)*"""

        return summary_md, table_md

    except Exception as e:
        return f"Error processing audio file: {str(e)}", ""


def compute_delay_from_bpm(bpm_val):
    try:
        bpm = float(bpm_val)
        if bpm <= 0:
            return "Please enter a valid positive BPM number."
        
        quarter_ms = 60000.0 / bpm
        eighth_ms = quarter_ms / 2.0
        dotted_eighth_ms = eighth_ms * 1.5
        sixteenth_ms = quarter_ms / 4.0
        triplet_ms = quarter_ms / 3.0

        return f"""### ⏱️ Delay & Reverb Timing Table ({bpm:.1f} BPM)

| Division | Milliseconds (ms) |
|---|---|
| **1/4 Quarter Note** | `{quarter_ms:.2f} ms` |
| **1/8 Eighth Note** | `{eighth_ms:.2f} ms` |
| **1/8d Dotted Eighth** | `{dotted_eighth_ms:.2f} ms` |
| **1/16 Sixteenth Note** | `{sixteenth_ms:.2f} ms` |
| **Triplet** | `{triplet_ms:.2f} ms` |

*Official Tool: [BPM Finder App](https://bpmfinderapp.com)*"""
    except ValueError:
        return "Invalid BPM value."


with gr.Blocks(theme=gr.themes.Soft()) as demo:
    gr.Markdown("# 🎵 BPM Finder App — Hugging Face Space\n[**Visit Official Web Application: bpmfinderapp.com**](https://bpmfinderapp.com)")

    with gr.Tab("Audio File Tempo Detector"):
        audio_input = gr.Audio(type="filepath", label="Upload Audio File (.wav, .mp3, .flac)")
        analyze_btn = gr.Button("Analyze Song BPM", variant="primary")
        result_summary = gr.Markdown()
        result_table = gr.Markdown()
        
        analyze_btn.click(
            fn=analyze_audio_file,
            inputs=[audio_input],
            outputs=[result_summary, result_table]
        )

    with gr.Tab("BPM to Delay Calculator"):
        bpm_input = gr.Number(value=120.0, label="Enter BPM Tempo")
        calc_btn = gr.Button("Calculate Delay Timings", variant="primary")
        delay_output = gr.Markdown()

        calc_btn.click(
            fn=compute_delay_from_bpm,
            inputs=[bpm_input],
            outputs=[delay_output]
        )

    gr.Markdown("*BPM Finder App is an open-source audio DSP tool published under NBK Devs. [https://bpmfinderapp.com](https://bpmfinderapp.com)*")

if __name__ == "__main__":
    demo.launch()
