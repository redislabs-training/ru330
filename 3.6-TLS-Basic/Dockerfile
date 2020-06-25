FROM redisuniversity/ru330-base

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
     mv redis.key /etc/ssl/private && \
     mv redis.crt /etc/ssl

RUN chown redis:redis /etc/ssl/private/* && \
    chmod 600 /etc/ssl/private/*

RUN chown redis:redis /etc/ssl/*.crt && \
    chmod 644 /etc/ssl/*.crt

RUN chown redis:redis /usr/local/share/ca-certificates/ca.crt && \
    chmod 644 /usr/local/share/ca-certificates/ca.crt

ADD redis.conf /etc/redis/redis.conf
RUN chmod 640 /etc/redis/redis.conf

RUN mkdir -p /ru330
ADD start-redis.sh /ru330
ADD redis-connect.sh /ru330
ADD stop-redis.sh /ru330

