# BPM Finder App - Official Docker Container

Official containerized audio analysis & tempo API microservice hosted on Docker Hub.

Powered by the [BPM Finder App](https://bpmfinderapp.com).

---

## Docker Hub Repository

[iamnazzal/bpm-finder-app](https://hub.docker.com/repository/docker/iamnazzal/bpm-finder-app)

---

## Quick Start

Run the container using Docker:

```bash
docker pull iamnazzal/bpm-finder-app:latest
docker run -d -p 8080:8080 --name bpm-finder-app iamnazzal/bpm-finder-app:latest
```

---

## Build & Push Instructions

```bash
cd packages/docker-bpm-finder
docker build -t iamnazzal/bpm-finder-app:latest -t iamnazzal/bpm-finder-app:1.0.0 .
docker login
docker push iamnazzal/bpm-finder-app:latest
docker push iamnazzal/bpm-finder-app:1.0.0
```

---

## API Endpoints

- `GET /health` : Health check endpoint.
- `GET /api/calculate-delay?bpm=120` : Returns delay note division math for any given BPM.

---

## Official Web Application

Visit the online audio file beat detection tool at the [BPM Finder App](https://bpmfinderapp.com).
