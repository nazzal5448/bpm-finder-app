from setuptools import setup, find_packages
import os

this_directory = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(this_directory, "README.md"), encoding="utf-8") as f:
    long_description = f.read()

setup(
    name="bpm-finder-app",
    version="1.0.0",
    description="Python library & CLI for automated audio tempo calculation, Tap BPM interval analysis, and delay/reverb timing formulas. Powered by the BPM Finder App.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    author="John Goldberg",
    author_email="support@bpmfinderapp.com",
    url="https://bpmfinderapp.com",
    packages=find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Topic :: Multimedia :: Sound/Audio :: Analysis",
    ],
    python_requires=">=3.7",
)
