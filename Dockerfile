FROM golang:latest

ARG checkout=master

RUN if [ "$checkout" = "master" ]; \
        then git clone --depth=1 https://go.googlesource.com/go /tmp/go; \
        else git clone https://go.googlesource.com/go /tmp/go; fi && \
    cd /tmp/go/src && \
    git checkout $checkout && \
    GOROOT_BOOTSTRAP=/usr/local/go GOROOT_FINAL=/usr/local/go ./make.bash && \
    cd - && \
    rm -rf /usr/local/go && \
    rm -rf /tmp/go/.git* && \
    mv /tmp/go /usr/local/go
