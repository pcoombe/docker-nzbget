# nzbget

NZBGet Docker container with dependencies for **sickbeard_mp4_automator** and other post-processing scripts.

## Base Image
- **nzbgetcom/nzbget:v22.0** - Official NZBGet Docker image

## Key Features
- Pre-installed **FFmpeg** & **libmediainfo** for media conversion & inspection
- Python 3 runtime with **pip**
- Core sickbeard_mp4_automator Python dependencies:
  - `requests`, `requests-cache` – HTTP with caching
  - `babelfish` – language/country codes
  - `tmdbsimple` – TMDB metadata
  - `mutagen` – audio tagging
  - `guessit` – filename parsing
  - `subliminal` – subtitle fetching
  - `qtfaststart` – MP4 atom optimization
  - `stevedore` – plugin loader (pinned 1.19.1)
- Download-client integrations:
  - `deluge-client` + `gevent` (Deluge)
  - `python-qbittorrent` (qBittorrent)
- Extras: `plexapi` (Plex notifications), `cleanit` (cleanup utility)

## Multi-Architecture Support
- **linux/amd64**
- **linux/arm64**

## Automated Versioning
Images are versioned automatically on every push to master:
- Format: `YYYY.MM.DD.COMMIT_COUNT` (e.g., `2026.10.24.142`)
- Also tagged as `latest`

## Registry
Images published to **GitHub Container Registry**:
```
ghcr.io/pcoombe/nzbget
```

## Build Arguments
- `BUILD_DATE` – Build timestamp
- `VCS_REF` – Git commit reference
- `VERSION` – Auto-calculated version number

## Labels (OCI / label-schema)
Build date, name, description, source URL, VCS ref/URL, vendor, version.

## Health Check
Container includes a health check hitting the NZBGet web UI on port **6789**.

## Usage

### Pull from GHCR (recommended)
```bash
docker pull ghcr.io/pcoombe/nzbget:latest
docker run -d \
  --name nzbget \
  -p 6789:6789 \
  -v /path/to/config:/config \
  -v /path/to/downloads:/downloads \
  ghcr.io/pcoombe/nzbget:latest
```

### Build locally
```bash
docker build -t nzbget .
docker run -d \
  --name nzbget \
  -p 6789:6789 \
  -v /path/to/config:/config \
  -v /path/to/downloads:/downloads \
  nzbget
```

## CI / CD

[![CI & Publish](https://github.com/pcoombe/nzbget/actions/workflows/ci.yml/badge.svg)](https://github.com/pcoombe/nzbget/actions/workflows/ci.yml)

- **CI & Publish** single workflow:
  - Runs on every PR/push to master – builds image and runs integration test against web UI
  - On push to master (not PR), after tests pass: builds multi-arch image, auto-versions (`YYYY.MM.DD.COMMIT_COUNT`), pushes to GHCR
  - Also runs weekly (Friday 15:00 UTC) and on manual dispatch
