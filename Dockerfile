FROM ubuntu:14.04
MAINTAINER wlu wlu@linkernetworks.com

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
	echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list

RUN apt-get install apt-transport-https && \
	apt-get -y update

RUN apt-get -y install mesos=0.26.0-0.2.145.ubuntu1404 supervisor docker-engine=1.10.1-0~trusty

RUN mkdir -p /var/mesos/external_log && \
    mkdir -p /var/mesos/log_dir && \
    mkdir -p /var/mesos/work

ADD supervisord.conf /etc/

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
