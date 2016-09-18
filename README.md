# **docker-golang**

[![Build Status](https://circleci.com/gh/vcabbage/docker-golang.svg?style=shield)](https://circleci.com/gh/vcabbage/docker-golang)

**Docker Hub Link: [vcabbage/golang](https://hub.docker.com/r/vcabbage/golang/)**

This Dockerfile builds a container with the Go toolchain from the master branch of the Go repository.

Downloading the prebuilt container from Docker Hub:

``` bash
docker pull vcabbage/golang
```

The build uses [golang:latest](https://hub.docker.com/_/golang/) to compile the toolchain, then replaces the 1.7 toolchain. The documentation in [Docker Hub golang repository](https://hub.docker.com/_/golang/) applies to this image.

### Building a Specific Branch or Commit

A specific branch or commit can be built by passing in the `branch` build arg.

```
$ docker build --build-arg branch=dev.ssa .
Sending build context to Docker daemon 133.6 kB
Step 1 : FROM golang:latest
 ---> 002b233310bb
Step 2 : ARG branch=master
 ---> Using cache
 ---> 2a53f12a1b34
Step 3 : RUN git clone https://go.googlesource.com/go /tmp/go &&     cd /tmp/go/src &&     git checkout $branch &&     GOROOT_BOOTSTRAP=/usr/local/go GOROOT_FINAL=/usr/local/go ./make.bash &&     cd - &&     rm -rf /usr/local/go &&     rm -rf /tmp/go/.git* &&     mv /tmp/go /usr/local/go
 ---> Running in f7d38341caf7
Cloning into '/tmp/go'...
Switched to a new branch 'dev.ssa'
Branch dev.ssa set up to track remote branch dev.ssa from origin.
##### Building Go bootstrap tool.
cmd/dist

##### Building Go toolchain using /usr/local/go.
[omitted]
---
Installed Go for linux/amd64 in /tmp/go
Installed commands in /tmp/go/bin

The binaries expect /tmp/go to be copied or moved to /usr/local/go
/go
 ---> aee3a3e6c1d6
Removing intermediate container f7d38341caf7
Successfully built aee3a3e6c1d6
```

```
$ docker run --rm aee3a3e6c1d6 go version
go version devel +d08010f Mon Aug 15 14:47:49 2016 +0000 linux/amd64
```

### Docker Hub Images

The Docker Hub images are automatically built when new commits are added to the Go repository, typically within 30 minutes.
Each image is tagged with the commit ID as seen in the output of `go version`.

In order to keep the images reasonably sized, [docker-squash](https://github.com/goldmann/docker-squash) is used to merge the image layers. This removes roughly 130MB from the final image.

For details on the build process, see [circle.yml](https://github.com/vcabbage/docker-golang/blob/master/circle.yml).