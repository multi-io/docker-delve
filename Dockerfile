FROM golang:1.14.3 AS builder

RUN git clone https://github.com/go-delve/delve.git /go/src/github.com/go-delve/delve && \
    cd /go/src/github.com/go-delve/delve && \
    git checkout v1.5.0 && \
    go install -ldflags "-X main.Build=$(git rev-parse HEAD) -extldflags \"-fno-PIC -static\"" -buildmode pie -tags 'osusergo netgo static_build' github.com/go-delve/delve/cmd/dlv

FROM golang:1.14.3

COPY --from=builder /go/bin/dlv /usr/bin/

RUN curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | bash && \
    apt install -y --no-install-recommends telepresence && \
    apt-get update && apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    touch /etc/apt/sources.list.d/kubernetes.list  && \
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

ENTRYPOINT ["/go/bin/dlv"]
