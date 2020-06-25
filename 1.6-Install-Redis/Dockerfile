FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN apt update -y

# Install some basic text editors
RUN apt install vim -y
RUN apt install nano -y

# Install build tools and utilities
RUN apt install build-essential tcl -y
RUN apt install tcl-tls -y
RUN apt install redis-tools -y
RUN apt install libssl-dev -y
RUN apt install wget -y

# Add a user for redis
RUN adduser --system --group --no-create-home redis && \
    chsh -s /bin/bash redis

RUN mkdir -p /data/redis
RUN chown redis:redis /data/redis
RUN chmod 770 /data/redis
RUN mkdir -p /var/log/redis
RUN mkdir /etc/redis
RUN touch /var/log/redis/redis.log
RUN chmod 770 /var/log/redis/
RUN chmod 640 /var/log/redis/redis.log
RUN chown redis:redis /var/log/redis
RUN chown redis:redis /var/log/redis/redis.log

RUN cd /tmp && \
    wget http://download.redis.io/releases/redis-6.0.5.tar.gz && \
    tar -xzvf redis-6.0.5.tar.gz && \
    cd redis-6.0.5 && \
    BUILD_TLS=yes make install

# Copy redis.conf file to /etc/redis
RUN cd /tmp/redis-6.0.5 && \
    cp redis.conf /etc/redis && \
    chown -R redis:redis /etc/redis && \
    chmod 640 /etc/redis/redis.conf
