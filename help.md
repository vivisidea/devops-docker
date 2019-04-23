
# devops tools

https://hub.docker.com/r/vivisidea/devops

These commands are available

arp, hostname, ifconfig, netstat, rarp, route, 
plipconfig, slattach, mii-tool and iptunnel and ipmaddr
arping clockdiff ninfod ping rarpd rdisc tftpd tracepath traceroute6
curl telnet ping nmap tcpdump
less
nano

If you need something else, search the repo using

```
/ # apk update
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
v3.9.3-32-g137dfb961b [http://dl-cdn.alpinelinux.org/alpine/v3.9/main]
v3.9.3-32-g137dfb961b [http://dl-cdn.alpinelinux.org/alpine/v3.9/community]
OK: 9755 distinct packages available

/ # apk list mysql-client
mysql-client-10.3.13-r0 x86_64 {mariadb} (GPL-2.0-or-later)

/ # apk add mysql-client
(1/6) Installing mariadb-common (10.3.13-r0)
(2/6) Installing ncurses-terminfo-base (6.1_p20190105-r0)
(3/6) Installing ncurses-terminfo (6.1_p20190105-r0)
(4/6) Installing ncurses-libs (6.1_p20190105-r0)
(5/6) Installing mariadb-client (10.3.13-r0)
(6/6) Installing mysql-client (10.3.13-r0)
Executing busybox-1.29.3-r10.trigger

/ # mysql --version
mysql  Ver 15.1 Distrib 10.3.13-MariaDB, for Linux (x86_64) using readline 5.1

```

https://pkgs.alpinelinux.org/packages