FROM bash:latest as build
RUN wget https://github.com/cloudflare/cloudflared/releases/download/2021.8.0/cloudflared-linux-arm
RUN chmod +x cloudflared-linux-arm

FROM gcr.io/distroless/base-debian10:nonroot

COPY --from=build --chown=nonroot cloudflared-linux-arm /usr/local/bin/cloudflared
USER nonroot

ENTRYPOINT ["/usr/local/bin/cloudflared", "--no-autoupdate"]
CMD ["version"]
