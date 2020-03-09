FROM centos:7

LABEL name="devops@vivi"
LABEL version="0.1"
LABEL description="make a ssh-able container"
MAINTAINER The CentOS Project <cloud-ops@centos.org>

ENV LANG en_US.UTF-8
ENV container docker
ARG USER=dev

WORKDIR /devops

# to run systemd inside container
# https://hub.docker.com/r/jrei/systemd-ubuntu/dockerfile
# docker run -d --name systemd-ubuntu --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro ssh-dev:latest
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

RUN rm -rf /etc/yum.repos.d/*
COPY Centos-7.repo /etc/yum.repos.d/
COPY epel-7.repo /etc/yum.repos.d/

RUN yum clean all && yum makecache \
    && yum install -y sudo openssh-server wget locales vim less curl telnet \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && localedef -c -f UTF-8 -i en_US en_US.utf8 

RUN printf "[global]\nindex-url = https://mirrors.aliyun.com/pypi/simple\nno-cache-dir = false\n" > /etc/pip.conf

#
# work with ssh login, sudo without password
#
RUN mkdir -p /run/sshd /var/run/sshd \
    && systemctl enable sshd.service \
    # "System is booting up. See pam_nologin(8)"
    && sed -i 's/account    required     pam_nologin.so/#account    required     pam_nologin.so/' /etc/pam.d/sshd \
    && useradd $USER --shell /bin/bash -d /home/$USER -m \
    && groupadd sudo \
    && usermod -aG sudo $USER \
    && usermod -aG systemd-journal $USER \
    && printf "$USER    ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev

COPY private.20191028.key.pub /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys && chmod 400 /home/$USER/.ssh/authorized_keys
COPY profile /home/$USER/.profile
COPY bashrc /home/$USER/.bashrc

EXPOSE 22
CMD ["/usr/sbin/init"]
