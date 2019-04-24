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
RUN apk --update --no-cache add \
    net-tools \
    iputils \
    nmap nmap-scripts nmap-ncat \
    curl tcpdump \
    bind-tools \
    busybox-extras \
    nginx \
    iperf \
    nano


COPY help.md /devops/

#
# https://stackoverflow.com/a/35770783
#
# This will keep your container alive until it is told to stop. Using trap and wait will make your container react immediately to a stop request. Without trap/wait stopping will take a few seconds.
#
CMD exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1000; done) & wait"






