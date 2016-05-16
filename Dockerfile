FROM ubuntu:14.04
MAINTAINER adolphlwq kenan3015@gmail.com

#set time zone
RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#install mesos
RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get -y update && \
    apt-get -y install mesos=0.26.0-0.2.145.ubuntu1404

#install docker
RUN apt-get install -y ca-certificates apt-transport-https && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list && \
    apt-get -y update && \
    apt-get install -y docker-engine=1.10.2-0~trusty && \
    apt-get clean

CMD ["mesos-slave"]
