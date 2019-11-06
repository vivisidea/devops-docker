FROM debian:9

LABEL name="devops@vivi"
LABEL version="0.1"
LABEL description="make a ssh-able container"

ENV LANG en_US.UTF-8
ARG USER=dev
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /devops

RUN sed -i 's/\(deb.debian.org\|security.debian.org\)/mirrors.163.com/' /etc/apt/sources.list \
    && apt update \
    && apt install -y openssh-server wget locales vim less curl telnet \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && localedef -c -f UTF-8 -i en_US en_US.utf8 \
    # install python & jdk8
    && apt install -y sudo openjdk-8-jdk  python3 python3-pip \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 20 \
    && printf "[global]\nindex-url = https://mirrors.aliyun.com/pypi/simple\nno-cache-dir = false\n" > /etc/pip.conf \
    && rm -rf /var/lib/apt/lists/*

#
# to run systemd inside container
# https://hub.docker.com/r/jrei/systemd-ubuntu/dockerfile
# docker run -d --name systemd-ubuntu --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro ssh-dev:latest
#
RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
        /etc/systemd/system/*.wants/* \
        /lib/systemd/system/local-fs.target.wants/* \
        /lib/systemd/system/sockets.target.wants/*udev* \
        /lib/systemd/system/sockets.target.wants/*initctl* \
        /lib/systemd/system/basic.target.wants/* \
        /lib/systemd/system/anaconda.target.wants/* \
        /lib/systemd/system/plymouth* \
        /lib/systemd/system/systemd-update-utmp*
VOLUME [ "/sys/fs/cgroup" ]

#
# work with ssh login, sudo without password
#
RUN mkdir -p /run/sshd /var/run/sshd \
    && systemctl enable ssh.service \
    # "System is booting up. See pam_nologin(8)"
    && sed -i 's/account    required     pam_nologin.so/#account    required     pam_nologin.so/' /etc/pam.d/sshd \
    && useradd $USER --shell /bin/bash -d /home/$USER -m \
    && usermod -aG sudo $USER \
    && usermod -aG systemd-journal $USER \
    && sed -i 's/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

COPY private.20191028.key.pub /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys && chmod 400 /home/$USER/.ssh/authorized_keys
COPY profile /home/$USER/.profile
COPY bashrc /home/$USER/.bashrc

EXPOSE 22
CMD ["/lib/systemd/systemd"]