FROM ocaml/opam2

LABEL maintainer="Kirill Mesnyankin <sadbox.games@gmail.com>"

# All liquidsoap dependencies
ENV PACKAGES " \
    cry ao portaudio alsa pulseaudio bjack gstreamer \
    mad taglib lame shine ogg vorbis speex theora opus fdkaac faad flac \
    ladspa soundtouch samplerate \
    gavl ffmpeg frei0r \
    dssi \
    xmlplaylist lastfm lo \
    dtools duppy mm liquidsoap \
    "

USER root

# For libfdk-aac-dev
RUN sed -e "s#main#main contrib non-free#" -i /etc/apt/sources.list && \
    apt-get update

USER opam

RUN opam depext $PACKAGES && \
    opam install --verbose $PACKAGES

ENTRYPOINT ["opam", "config", "exec", "--", "liquidsoap"]
CMD ["-h"]
