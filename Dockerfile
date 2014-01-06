FROM ubuntu

MAINTAINER scottjab

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential python-dev liblzma-dev libevent-dev libssl-dev python-pip git-core sudo

RUN useradd registry -d /home/registry -m
RUN sudo -u registry mkdir -p /home/registry/images
RUN sudo -u registry git clone https://github.com/dotcloud/docker-registry /home/registry/docker-registry
RUN ( cd /home/registry/docker-registry && git checkout tags/0.6.1 )
# Fuck virtualenvs (not really, but this is simpler)
RUN ( cd /home/registry/docker-registry && pip install -r requirements.txt )
RUN ( sudo -u registry cp /home/registry/docker-registry/config_sample.yml /home/registry/docker-registry/config.yml )

EXPOSE 5000
CMD ( cd /home/registry/docker-registry && sudo -u registry ./run.sh )
