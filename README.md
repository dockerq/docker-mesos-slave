# mesos slave on docker
## introduction
This dockerfile aims to run mesos slave in docker image.
[Mesos](http://mesos.apache.org/) is an excellent cluster resources management framework.
It provide a isolation between tasks both with Linux Containers and Docker containers.
Mesos slaves responsible for running tasks.
In my repo I run Mesos in docker container and mesos tasks in docker containers.
To realize this pupose I must install docker in mesos slave container.

## requirements
- docker
- docker-compose
- zookeeper

## usage
1. clone this repo
```
git clone https://github.com/dockerq/docker-mesos-slave.git
```
2. build mesos slave docker image
```
docker build -t image_name .
```
3. change image url in docker-compose.yml
```
mesos_slave:
    image: your_image_name
    net: "host"
    privileged: true
    volumes:
      - /var/mesos_slave:/var/mesos_slave
      - /var/run/docker.sock:/var/run/docker.sock
      - /sys/fs/cgroup:/sys/fs/cgroup
    container_name: mesos_slave
    env_file: mesos_slave_env
```
4. change env in mesos_slave_env file
```
...
MESOS_LOGGING_LEVEL=INFO
MESOS_IP=192.168.10.142
...
```
for more configs click [mesos config](http://mesos.apache.org/documentation/latest/configuration/)
5. run mesos slave
```
docker-compose -f ./docker-compose.yml up -d
```

## note
- If you run Mesos in cluster.You need mesos master and mesos slave and zookeeler.for more infomation click [mesos cluster setup](https://github.com/DHOPL/docker-mesos-marathon-cluster)
- the docker version on mesos container must the same in host
