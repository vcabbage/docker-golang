FROM golang:latest

ARG branch=master

RUN git clone https://go.googlesource.com/go /tmp/go && \
    cd /tmp/go/src && \
    git checkout $branch && \
    GOROOT_BOOTSTRAP=/usr/local/go GOROOT_FINAL=/usr/local/go ./make.bash && \
    cd - && \
    rm -rf /usr/local/go && \
    rm -rf /tmp/go/.git* && \
    mv /tmp/go /usr/local/go
