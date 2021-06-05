FROM golang:1.16 as builder

ARG MAKE_GOAL

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY . /build/
WORKDIR /build

RUN curl -sfL https://install.goreleaser.com/github.com/goreleaser/goreleaser.sh | sh

RUN ./bin/goreleaser build --snapshot

# Final image build
FROM gcr.io/distroless/base-debian10:debug

COPY --from=builder --chown=65532:65532 /build/build/dist/mjpeg-proxy_linux_amd64/mjpeg-proxy /app/

USER nonroot

WORKDIR /app
ENTRYPOINT ["./mjpeg-proxy"]