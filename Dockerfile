FROM bash:latest as build
ENV RELEASE 2021.9.2
RUN wget https://github.com/cloudflare/cloudflared/releases/download/$RELEASE/cloudflared-linux-arm
RUN chmod +x cloudflared-linux-arm

FROM gcr.io/distroless/base-debian10:nonroot

COPY --from=build --chown=nonroot cloudflared-linux-arm /usr/local/bin/cloudflared
USER nonroot

ENTRYPOINT ["/usr/local/bin/cloudflared", "--no-autoupdate"]
CMD ["version"]
