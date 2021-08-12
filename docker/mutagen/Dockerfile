# Use a minimal base image.
FROM alpine:latest

WORKDIR /root/project

# install envsubst
RUN apk update && apk add --no-cache gettext

# install mutagen
RUN case $(arch) in \
        x86_64) \
            export ARCH=amd64 \
            ;; \
    esac \
    && wget -O- https://github.com/mutagen-io/mutagen/releases/download/v0.11.8/mutagen_linux_${ARCH}_v0.11.8.tar.gz \
        | tar -xvzf - mutagen -C /usr/local/bin

COPY ./mutagen.tpl.yml /root/project/
COPY ./mutagen.init.sh /usr/local/bin/init

RUN chmod +x /usr/local/bin/*

CMD ["/usr/local/bin/init"]
