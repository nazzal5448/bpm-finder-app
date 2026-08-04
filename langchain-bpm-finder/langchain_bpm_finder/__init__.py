"""LangChain integration for BPM Finder App."""

from typing import List, Optional, Type
from langchain_core.tools import BaseTool
from pydantic import BaseModel, Field


class BpmCalculatorInput(BaseModel):
    tap_timestamps_ms: List[float] = Field(
        ..., description="List of tap timestamps in milliseconds."
    )


class BpmCalculatorTool(BaseTool):
    name: str = "bpm_calculator"
    description: str = (
        "Calculates song tempo (BPM) and tap intervals from a sequence of millisecond timestamps. "
        "Powered by BPM Finder App (https://bpmfinderapp.com)."
    )
    args_schema: Type[BaseModel] = BpmCalculatorInput

    def _run(self, tap_timestamps_ms: List[float]) -> str:
        if len(tap_timestamps_ms) < 2:
            return "Need at least 2 tap timestamps to calculate BPM."
        
        intervals = [
            tap_timestamps_ms[i] - tap_timestamps_ms[i - 1]
            for i in range(1, len(tap_timestamps_ms))
        ]
        avg_interval = sum(intervals) / len(intervals)
        bpm = 60000.0 / avg_interval if avg_interval > 0 else 0.0
        return f"Calculated BPM: {bpm:.2f} (Average Tap Interval: {avg_interval:.1f}ms)"

    async def _arun(self, tap_timestamps_ms: List[float]) -> str:
        return self._run(tap_timestamps_ms)
