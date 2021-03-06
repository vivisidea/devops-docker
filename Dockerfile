FROM alpine:3.9

LABEL name="devops@vivi"
LABEL version="0.1"
LABEL description="collection of dev tools"

WORKDIR /devops

# net-tools
# https://sourceforge.net/projects/net-tools/
#
# arp, hostname, ifconfig, netstat, rarp, route, plipconfig, slattach, mii-tool and iptunnel and ipmaddr.
#
# iputils
# https://github.com/iputils/iputils/
# arping clockdiff ninfod ping rarpd rdisc tftpd tracepath traceroute6
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --update --no-cache add \
    net-tools \
    iputils \
    apache2-utils \
    nmap nmap-scripts nmap-ncat \
    curl tcpdump \
    bind-tools \
    busybox-extras \
    nginx \
    iperf \
    bash \
    coreutils \
    nano \
    && ln -s /usr/bin/vi /usr/bin/view \
    && ln -s /usr/bin/vi /usr/bin/vim \
    && mkdir -p /var/run/nginx \
    && sed 's/worker_processes auto;/worker_processes 2;/' -i /etc/nginx/nginx.conf


COPY help.md /devops/
COPY nginx/default.conf /etc/nginx/conf.d/
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
