# Transparent Proxy Docker image

## Description

This image propose a model of transparent proxy to run on a Docker engine.

The model is to have a single "entrypoint" to configure your corporate
proxy, which will capture transparently all the traffic from your
containers. It avoids you to configure your proxy on all your tools.

The idea comes from this article: https://jpetazzo.github.io/2014/06/17/transparent-squid-proxy-docker/.

We use "redsocks" https://github.com/darkk/redsocks for its size and
its full TCP support.

[![Build Status](https://travis-ci.org/dduportal-dockerfiles/bats.svg?branch=master)](https://travis-ci.org/dduportal-dockerfiles/bats)

## Usage

Pull the image from the DockerHub registry:

```
docker pull dduportal/transparent-proxy
```

Starting the proxy:

```
docker run --rm --name transparent-proxy --privileged=true --net=host -d dduportal/transparent-proxy <PROXY_IP> <PROXY_PORT> <NO_PROXY_PATTERN>
```

Stopping the proxy:

```
docker stop proxsocks
```

## Contributing

Contributions are welcome!
It is based on the free time you have to help:

### I have 1 minute

* Simply an issue describing your challenge/problem/bug,
or the goal you want to achieve

### I have 1 hour

* Open an issue (see "I have 1 minute")
* Ensure you have on your machine:
  - [Docker](https://www.docker.com/),
  - Bash and GNU Make (the command `make`)
  - Git
* Fork this repository
* Clone your fork on your machine
* Write test(s) in `/tests/`
* (Re)Write the Dockerfile
* (Re)Write the documentation if needed
* Run `make all`
* If NOT OK, fix and iterate
* If OK, commit and push
* Finally, open a Pull Request with a link to the issue
you had raised earlier
  - The CI system will automatically build and test for you providing feedback
