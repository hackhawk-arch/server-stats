FROM alpine:3.20

LABEL maintainer="Kelvin Macharia"
LABEL description="Lightweight Linux server health monitoring script"

# Install required tools
RUN apk add --no-cache \
    bash \
    coreutils \
    procps \
    util-linux \
    busybox-extras

WORKDIR /server-stats

COPY server-stats.sh .
RUN chmod +x server-stats.sh

# Force Bash (Alpine default shell is ash)
ENTRYPOINT ["bash", "/server-stats/server-stats.sh"]