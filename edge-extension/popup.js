document.addEventListener("DOMContentLoaded", () => {
  let tapTimestamps = [];
  const RESET_TIMEOUT_MS = 3000;
  let resetTimer = null;

  const bpmValueEl = document.getElementById("bpmValue");
  const bpmStatusEl = document.getElementById("bpmStatus");
  const tapCountEl = document.getElementById("tapCount");
  const tempoCategoryEl = document.getElementById("tempoCategory");
  const tapBtn = document.getElementById("tapBtn");
  const resetBtn = document.getElementById("resetBtn");

  function getTempoCategory(bpm) {
    if (bpm < 60) return "Largo";
    if (bpm < 76) return "Adagio";
    if (bpm < 108) return "Andante";
    if (bpm < 120) return "Moderato";
    if (bpm < 140) return "Allegro";
    if (bpm < 168) return "Presto";
    return "Prestissimo";
  }

  function handleTap() {
    const now = performance.now();

    // Auto-reset if last tap was longer than RESET_TIMEOUT_MS ago
    if (tapTimestamps.length > 0 && now - tapTimestamps[tapTimestamps.length - 1] > RESET_TIMEOUT_MS) {
      tapTimestamps = [];
    }

    tapTimestamps.push(now);

    if (resetTimer) clearTimeout(resetTimer);
    resetTimer = setTimeout(() => {
      // Keep calculated value displayed
    }, RESET_TIMEOUT_MS);

    updateUI();
  }

  function resetTaps() {
    tapTimestamps = [];
    if (resetTimer) clearTimeout(resetTimer);
    bpmValueEl.textContent = "--";
    bpmStatusEl.textContent = "Tap the beat or press Spacebar";
    tapCountEl.textContent = "0";
    tempoCategoryEl.textContent = "--";
  }

  function updateUI() {
    tapCountEl.textContent = tapTimestamps.length.toString();

    if (tapTimestamps.length < 2) {
      bpmStatusEl.textContent = "Keep tapping (1/2 minimum)...";
      return;
    }

    // Calculate intervals
    const intervals = [];
    for (let i = 1; i < tapTimestamps.length; i++) {
      intervals.push(tapTimestamps[i] - tapTimestamps[i - 1]);
    }

    // Average interval in ms
    const avgInterval = intervals.reduce((a, b) => a + b, 0) / intervals.length;
    const bpm = Math.round(60000 / avgInterval);

    if (bpm >= 30 && bpm <= 300) {
      bpmValueEl.textContent = bpm.toString();
      tempoCategoryEl.textContent = getTempoCategory(bpm);
      bpmStatusEl.textContent = `${tapTimestamps.length} taps analyzed`;
    }
  }

  tapBtn.addEventListener("click", handleTap);
  resetBtn.addEventListener("click", resetTaps);

  document.addEventListener("keydown", (e) => {
    if (e.code === "Space" || e.code === "Enter") {
      e.preventDefault();
      handleTap();
    }
  });
});
