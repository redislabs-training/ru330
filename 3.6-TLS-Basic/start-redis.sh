set -x
/usr/local/bin/redis-server /etc/redis/redis.conf 2>&1 > redis.out &
