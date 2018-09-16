FROM golang:1.10.3

RUN go get -u github.com/derekparker/delve/cmd/dlv

ENTRYPOINT ["/go/bin/dlv"]
