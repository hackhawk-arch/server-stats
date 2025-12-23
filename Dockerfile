FROM alpine:3.20

LABEL maintainer=" Kelvin Macharia"
LABEL description="Lightweight linux server health monitoring script"

# Install required tools
RUN apk add --no-cache \
    bash \
    coreutils \
    procps \
    util-linux \
    busybox-extras

WORKDIR /server-stats

COPY server-stats.sh /server-stats/server-stats.sh
RUN chmod +x /server-stats/server-stats.sh

ENTRYPOINT [ "/server-stats/server-stats.sh" ]