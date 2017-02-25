FROM docker:latest

#RUN set -o xtrace -o errexit &&\
#    apk add --update --virtual .build-deps bash wget gcc make git musl-dev go &&\
#    apk add ca-certificates && update-ca-certificates  &&\
#\
#    export GOROOT_BOOTSTRAP="$(go env GOROOT)" &&\
#    export GOPATH="/go" &&\
#    export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH" &&\
#\
#    wget --quiet --show-progress --progress=bar:force:noscroll https://golang.org/dl/go1.7.src.tar.gz -O golang.tar.gz &&\
#    tar -C /usr/local -xzf golang.tar.gz &&\
#    rm golang.tar.gz &&\
#\
#    cd /usr/local/go/src &&\
#    wget --quiet --show-progress --progress=bar:force:noscroll \
#        https://raw.githubusercontent.com/docker-library/golang/ca728c5e13b90088d0b48aaf4108bbe31838d8d1/1.7/alpine/no-pic.patch &&\
#    patch -p2 -i no-pic.patch &&\
#    ./make.bash &&\
#    mkdir -p "$GOPATH/src" "$GOPATH/bin" &&\
#	  chmod -R 777 "$GOPATH" &&\
#\
#    cd /go &&\
#    go get -d github.com/grammarly/rocker &&\
#    cd /go/src/github.com/grammarly/rocker &&\
#	  go build -ldflags "-X main.Version=$(cat VERSION) -X main.GitCommit=$(git rev-parse HEAD 2>/dev/null) -X main.GitBranch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) -X main.BuildTime=$(TZ=GMT date '+%Y-%m-%d_%H:%M_GMT')" &&\
#    mv rocker /usr/bin &&\
#    apk del --purge --rdepends --clean-protected .build-deps &&\
#    rm -rf /var/cache/apk/* &&\
#    rm -rf /usr/local/go &&\
#    rm -rf /go

RUN apk add --update ca-certificates wget tar &&\
    update-ca-certificates &&\
    wget --quiet --show-progress --progress=bar:force:noscroll https://github.com/grammarly/rocker/releases/download/1.3.0/rocker_linux_amd64.tar.gz &&\
    tar -xvf rocker_linux_amd64.tar.gz --no-same-owner -C /usr/bin &&\
    chmod +x /usr/bin/rocker &&\
    rm rocker_linux_amd64.tar.gz &&\
    apk del --purge --rdepends --clean-protected ca-certificates wget tar &&\
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["sh"]
