set -x
/usr/local/bin/redis-cli --tls --cacert /usr/local/share/ca-certificates/ca.crt --cert /etc/ssl/clients/client.crt --key /etc/ssl/clients/client.key shutdown
