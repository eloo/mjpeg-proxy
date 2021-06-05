FROM gcr.io/distroless/base-debian10:debug

COPY mjpeg-proxy /app/

USER nonroot

WORKDIR /app
ENTRYPOINT ["./mjpeg-proxy"]