FROM golang:1.21.2 AS builder

ARG DLV_VERSION

RUN CGO_ENABLED=0 go install -ldflags "-w -extldflags '-static'" github.com/go-delve/delve/cmd/dlv@${DLV_VERSION}

FROM alpine:latest AS minimal

COPY --from=builder /go/bin/dlv /usr/bin/

ENTRYPOINT ["/usr/bin/dlv"]


FROM golang:1.21.2 AS sumo

COPY --from=builder /go/bin/dlv /usr/bin/

RUN curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl
# curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.17.1/telepresence-linux-amd64 -o /usr/local/bin/telepresence # 404

