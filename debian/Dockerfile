FROM debian:9

LABEL name="devops@vivi"
LABEL version="0.1"
LABEL description="make a ssh-able container"

ENV LANG en_US.UTF-8

WORKDIR /devops

RUN sed -i 's/\(deb.debian.org\|security.debian.org\)/mirrors.163.com/' /etc/apt/sources.list
# RUN printf "[global]\nindex-url = https://mirrors.aliyun.com/pypi/simple\nno-cache-dir = false\n" > /etc/pip.conf

RUN apt update
RUN apt install -y openssh-server
RUN apt-get update && apt-get install -y wget locales vim less curl telnet \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && localedef -c -f UTF-8 -i en_US en_US.utf8 \
    && rm -rf /var/lib/apt/lists/*

ARG USER=dev

RUN apt update && apt install -y sudo openjdk-8-jdk
RUN mkdir -p /run/sshd \
    && mkdir -p /var/run/sshd \
    && useradd $USER --shell /bin/bash -d /home/$USER -m \
    && usermod -aG sudo $USER \
    && sed -i 's/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

COPY private.20191028.key.pub /home/$USER/.ssh/authorized_keys
COPY profile /home/$USER/.profile
COPY bashrc /home/$USER/.bashrc

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]