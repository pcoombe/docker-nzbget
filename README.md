# docker-nzbget

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

## Build Arguments
- `BUILD_DATE` – Build timestamp
- `VCS_REF` – Git commit reference
- `VERSION` – Version number

## Labels (OCI / label-schema)
Build date, name, description, source URL, VCS ref/URL, vendor, version.

## Health Check
Container includes a health check hitting the NZBGet web UI on port **6789**.

## Usage

```bash
docker build -t nzbget .
docker run -d \
  --name nzbget \
  -p 6789:6789 \
  -v /path/to/config:/config \
  -v /path/to/downloads:/downloads \
  nzbget
```

## GitHub Actions
[![publish](https://github.com/pcoombe/docker-nzbget/actions/workflows/publish.yml/badge.svg)](https://github.com/pcoombe/docker-nzbget/actions/workflows/publish.yml)
