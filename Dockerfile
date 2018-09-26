FROM golang:1.10.3

RUN go get -u github.com/derekparker/delve/cmd/dlv && \
    curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | bash && \
    apt install -y --no-install-recommends telepresence && \
    apt-get update && apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    touch /etc/apt/sources.list.d/kubernetes.list  && \
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

ENTRYPOINT ["/go/bin/dlv"]
