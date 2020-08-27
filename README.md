# RU330 Redis Security

This repository contains example Docker files to be used with the [RU330 Redis Security](https://university.redislabs.com/courses/ru330/) course at Redis University.

## Prerequisites

You will need to install Docker to use the resources in this repository.  Installation instructions for Mac, Windows and Linux [can be found here](https://docs.docker.com/get-docker/).  Make sure Docker is running before you attempt to build the containers.

## Resources for Week 1 of the Course

### Installing Redis Securely

The folder "1.6-Install-Redis" contains a Docker file, scripts, and Redis configuration file that build a container with Redis installed and configured as described in week 1's "Installing Redis Securely" video.

Use the `build.sh` script to build the container, and the `login.sh` script to start it and connect via a bash shell.

Once logged into the container, you can start Redis with:

```bash
# redis-server &
```

And connect to it using:

```bash
# redis-cli
```

## Resources for Week 3 of the Course

### TLS in Redis - Encrypting Connections

The folder "3.6-TLS-Basic" accompanies the week 3 video "Encrypting Connections".  It contains a Docker file and scripts to build a container that demonstrates how to make a secure connection to Redis.

Use the `build.sh` script to build the container, and the `login.sh` script to start it and connect via a bash shell.

Once you're connected to the bash shell in the container, change directory to the `ru330` folder:

```bash
# cd ru330
```

From here, you can run:

* `./start-redis.sh` - starts the Redis server in the background, with log output to `redis.out`.
* `./redis-connect.sh` - uses `redis-cli` to make a secure connection to the Redis server.
* `./stop-redis.sh` - stops the Redis server process.


### TLS in Redis - TLS 1.3, Mutual Authentication and Advanced TLS Configuration

The folder "3.7-TLS-Advanced" accompanies the week 3 video "TLS 1.3, Mutual Authentication and Advanced TLS Configuration".  It contains a Docker file and scripts showing a way to make a more advanced secure connection to Redis.

Use the `build.sh` script to build the container, and the `login.sh` script to start is and connect via a bash shell.

Once you're connected to the bash shell in the container, change directory to the `ru330` folder:

```bash
# cd ru330
```

From here, you can run:

* `./start-redis.sh` - starts the Redis server in the background, with log output to `/var/log/redis.out`.
* `./redis-connect.sh` - uses `redis-cli` to make a secure connection to the Redis server.
* `./stop-redis.sh` - stops the Redis server process.

## Need Help?

If you need help with the resources in this repository, join us on the [Redis University Discord](https://discord.gg/4StRkuH) server where we have a dedicated channel `#ru330-redis-security` for this course.
