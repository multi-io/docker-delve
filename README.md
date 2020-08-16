# Go Delve Image

Source: https://github.com/multi-io/docker-delve

Usually run with the binary to be debugged mounted into the container. You could
also copy the dlv binary (which is linked statically) out of the container into
the to-be-debugged container, e.g. if you use this image in a K8s
InitContainer.

IMPORTANT: You need to run the container with `--security-opt
seccomp:unconfined`. Otherwise Delve will abort with `could not launch
process: fork/exec <binary>: operation not permitted`.

Binaries need to be compiled with debugging symbols (`-gcflags 'all=-N
-l'`) for Delve to work with them.

Sample invocation, assuming the binary to be debugged is located at
`output/binary` on the host:

```
docker run --security-opt seccomp:unconfined -v `pwd`/output:/output -p 2345:2345 oklischat/delve --listen=:2345 --headless=true --api-version=2 exec /output/binary -- <arguments>
```

You should now be able to connect any debugging client running on the
host (e.g delve itself, or an IDE like Goland) to the debugged process
at `localhost:2345`.
