FROM linuxserver/nzbget
MAINTAINER pcoombe

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="NZBGet" \
    org.label-schema.description="Nzbget container with dependencies for sickbeard_mp4_automator" \
    org.label-schema.url="https://github.com/pcoombe/docker-nzbget" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/pcoombe/docker-nzbget" \
    org.label-schema.vendor="pcoombe" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \    
    org.opencontainers.image.source="https://github.com/pcoombe/docker-nzbget"

# install permanent packages
RUN \
 apk add --no-cache \
	git \
	ffmpeg \
	libmediainfo \
	python2 \
	python3 \
	py-pip
	
# install development and python packages
RUN \
 apk add --no-cache \
	python2-dev \
	python3-dev \
	libffi-dev \
	openssl-dev \
	build-base \
	gcc \
	abuild \
	binutils \
	cmake && \
 pip install --upgrade "pip" && \
 pip install wheel && \
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
	python2-dev \
	python3-dev \
	libffi-dev \
	openssl-dev \
	build-base \
	gcc \
	abuild \
	binutils \
	cmake 

# link ffmpeg
RUN \	
 ln -s /usr/bin/ffmpeg /usr/local/bin/ffmpeg && \
 ln -s /usr/bin/ffprobe /usr/local/bin/ffprobe
