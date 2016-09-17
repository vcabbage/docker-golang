FROM golang:latest

ARG branch=master

RUN git clone https://go.googlesource.com/go && \
    cd go/src && \
    git checkout $branch && \
    GOROOT_BOOTSTRAP=/usr/local/go GOROOT_FINAL=/usr/local/go ./make.bash && \
    cd - && \
    rm -rf /usr/local/go && \
    mv /go/go /usr/local/go && \
    rm -rf /go
