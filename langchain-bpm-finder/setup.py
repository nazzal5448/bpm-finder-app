from setuptools import setup, find_packages

setup(
    name="langchain-bpm-finder",
    version="1.0.0",
    description="LangChain integration tool for BPM Finder App tempo detection and audio timing calculations.",
    long_description=open("README.md", "r", encoding="utf-8").read(),
    long_description_content_type="text/markdown",
    author="BPM Finder Team",
    author_email="support@bpmfinderapp.com",
    url="https://bpmfinderapp.com",
    project_urls={
        "Homepage": "https://bpmfinderapp.com",
        "Source": "https://github.com/nazzal5448/bpm-finder-app",
        "Documentation": "https://bpmfinderapp.com/bpm-finder",
    },
    packages=find_packages(),
    install_requires=[
        "langchain-core>=0.1.0",
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Topic :: Multimedia :: Sound/Audio :: Analysis",
    ],
    python_requires=">=3.8",
)
