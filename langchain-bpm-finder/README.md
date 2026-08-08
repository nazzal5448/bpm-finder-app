# langchain-bpm-finder

Official [LangChain](https://python.langchain.com/) tool integration for the **[BPM Finder App](https://bpmfinderapp.com)**.

## Installation

```bash
pip install langchain-bpm-finder
```

## Quickstart

```python
from langchain_bpm_finder import BpmCalculatorTool

tool = BpmCalculatorTool()
result = tool.run([0.0, 500.0, 1000.0, 1500.0])
print(result) # Calculated BPM: 120.00 (Average Tap Interval: 500.0ms)
```

Powered by [BPM Finder App](https://bpmfinderapp.com).
