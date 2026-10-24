FROM nzbgetcom/nzbget:v22.0

LABEL maintainer="pcoombe" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="NZBGet" \
    org.label-schema.description="Nzbget container with dependencies for sickbeard_mp4_automator" \
    org.label-schema.url="https://github.com/pcoombe/docker-nzbget" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/pcoombe/docker-nzbget" \
    org.label-schema.vendor="pcoombe" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    org.opencontainers.image.source="https://github.com/pcoombe/docker-nzbget"

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

WORKDIR /config

# Install runtime dependencies
RUN apk add --no-cache \
    git \
    ffmpeg \
    libmediainfo \
    python3 \
    py3-pip

# Install build dependencies, compile Python packages, then clean up
RUN apk add --no-cache --virtual .build-deps \
    python3-dev \
    libffi-dev \
    openssl-dev \
    build-base \
    gcc \
    abuild \
    binutils \
    cmake && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    wheel \
    setuptools \
    requests \
    "requests[security]" \
    requests-cache \
    "idna<3" \
    babelfish \
    "tmdbsimple<2.3" \
    "mutagen<1.44" \
    "guessit<2" \
    "pymediainfo<5" \
    deluge-client \
    gevent \
    qtfaststart \
    "subliminal<2" \
    stevedore==1.19.1 \
    plexapi \
    cleanit \
    python-qbittorrent && \
    apk del --no-cache .build-deps

# link ffmpeg
RUN \
 ln -s /usr/bin/ffmpeg /usr/local/bin/ffmpeg && \
 ln -s /usr/bin/ffprobe /usr/local/bin/ffprobe

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:6789/ || exit 1
