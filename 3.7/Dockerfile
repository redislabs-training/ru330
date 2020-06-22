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

# Generate Issuing Certificate and Key
RUN cd /tmp && \
    openssl genrsa -out ca.key 4096 && \
    openssl req \
      -x509 -new -nodes -sha256 \
      -key ca.key \
      -days 3650 \
      -subj '/O=Redislabs/CN=Redis Prod CA' \
      -out ca.crt && \
     mv ca.key /etc/ssl/private && \
     mv ca.crt /usr/local/share/ca-certificates
     
# Generate Redis server certificate and key
RUN cd /tmp && \
    openssl genrsa -out redis.key 2048 && \
    openssl req \
    -new -sha256 \
    -key redis.key \
    -subj '/O=Redislabs/CN=Production Redis' | \
    openssl x509 \
        -req -sha256 \
        -CA /usr/local/share/ca-certificates/ca.crt \
        -CAkey /etc/ssl/private/ca.key \
        -CAserial /etc/ssl/private/ca.txt \
        -CAcreateserial \
        -days 365 \
        -out redis.crt && \
     mv redis.* /etc/ssl/private

# Generate Redis client certificate and key
RUN openssl genrsa -out client.key 2048 && \
    openssl req \
    -new -sha256 \
    -key client.key \
    -subj '/O=Redislabs/CN=Production Redis Client Cert' | \
    openssl x509 \
        -req -sha256 \
        -CA /usr/local/share/ca-certificates/ca.crt \
        -CAkey /etc/ssl/private/ca.key \
        -CAserial /etc/ssl/private/ca.txt \
        -CAcreateserial \
        -days 365 \
        -out client.crt && \
     mv client.* /etc/ssl/private

RUN chown redis:redis /etc/ssl/private/* && \
    chmod 0400 /etc/ssl/private/*

ADD redis.conf /etc/redis/redis.conf
RUN chmod 640 /etc/redis/redis.conf
