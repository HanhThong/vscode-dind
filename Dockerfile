FROM ubuntu:22.04

WORKDIR /tmp
COPY ./install-scripts install-scripts/
RUN bash install-scripts/install_docker.sh
RUN bash install-scripts/install_supervisor.sh
RUN rm -r /tmp/*
COPY supervisor/ /etc/supervisor/conf.d/
RUN chmod +x /opt/bash-utils/startup.sh
VOLUME /var/lib/docker

RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
CMD ["/usr/bin/supervisord", "-n"]
