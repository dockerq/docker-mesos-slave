FROM mesosphere/mesos-master:0.26.0-0.2.145.ubuntu1404
MAINTAINER wlu wlu@linkernetworks.com

RUN apt-get install -y vim supervisor && \
    echo "set number" >> /etc/vimrc && \
    echo "set ts=4" >> /etc/vimrc && \
    echo "set expandtab" >> /etc/vimrc && \
    echo "set autoindent" >> /etc/vimrc

RUN mkdir -p /var/mesos/external_log && \
    mkdir -p /var/mesos/log_dir && \
    mkdir -p /var/mesos/work

ADD supervisord.conf /etc/

RUN curl -fLsS https://get.docker.com/ | sh

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
