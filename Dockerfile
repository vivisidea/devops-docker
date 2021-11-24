FROM debian:buster

LABEL name="devops@vivi"
LABEL version="0.1"
LABEL description="devops tools for k8s"

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /devops

RUN sed -i 's/\(deb.debian.org\|security.debian.org\)/mirrors.163.com/' /etc/apt/sources.list \
    && apt update \
    && apt install -y wget curl telnet \
        less \
        mtr-tiny \
        procps \
        net-tools \
        netcat \
        nmap \
        tcpdump \
        dnsutils \
        nginx \
        iperf \
        coreutils \
        nano \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*


COPY help.md /devops/
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/sites-enabled/default
COPY nginx/index.html /var/www/

COPY docker-entrypoint.sh /devops/
RUN chmod +x /devops/docker-entrypoint.sh

#
# https://stackoverflow.com/a/35770783
#
# This will keep your container alive until it is told to stop. Using trap and wait will make your container react immediately to a stop request. Without trap/wait stopping will take a few seconds.
#
#CMD exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1000; done) & wait"

ENTRYPOINT [ "/devops/docker-entrypoint.sh" ]
