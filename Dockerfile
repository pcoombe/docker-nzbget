FROM linuxserver/nzbget
MAINTAINER pcoombe

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="Nzbget" \
    org.label-schema.description="Nzbget container with dependencies for sickbeard_mp4_automator" \
    org.label-schema.url="http://ullberg.us/docker/nzbget" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/pcoombe/docker-nzbget" \
    org.label-schema.vendor="pcoombe" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

# install packages
RUN \
 apk add --no-cache \
	ffmpeg \
	py-pip \
	python3 \
	python-dev \
	python3-dev \
	libffi-dev \
	openssl-dev \
	build-base \
	gcc \
	abuild \
	binutils \
	git \
	cmake && \
 pip install --upgrade pip && \
 pip install setuptools && \
 pip install requests && \
 pip install requests[security] && \
 pip install requests-cache && \
 pip install "idna<3" && \
 pip install babelfish && \
 pip install "tmdbsimple<2.3" && \
 pip install "mutagen<1.44" && \
 pip install "guessit<2" && \
 pip install "pymediainfo<5" && \
 pip install deluge-client && \
 pip install gevent && \
 pip install qtfaststart && \
 pip install "subliminal<2" && \
 pip install stevedore==1.19.1 && \
 apk del --no-cache \
	python-dev \
	python3-dev \
	libffi-dev \
	openssl-dev \
	build-base \
	gcc \
	abuild \
	binutils \
	cmake 
