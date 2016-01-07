FROM centos:6
MAINTAINER wlu wlu@linkernetworks.com

RUN rpm -Uvh http://repos.mesosphere.com/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm && \
    yum -y install mesos

RUN yum install -y vim net-tools && \
    echo "set number" >> /etc/vimrc && \
    echo "set ts=4" >> /etc/vimrc && \
    echo "set expandtab" >> /etc/vimrc && \
    echo "set autoindent" >> /etc/vimrc

ADD *.sh /usr/etc/mesos/
RUN chmod +x /usr/etc/mesos/*.sh

RUN yum install -y python-setuptools && \
    easy_install supervisor && \
    mkdir -p /var/mesos/external_log && \
    mkdir -p /var/mesos/log_dir && \
    mkdir -p /var/mesos/work

ADD supervisord.conf /etc/

EXPOSE 5050 5051

RUN curl -fLsS https://get.docker.com/ | sh

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
