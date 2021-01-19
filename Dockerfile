FROM alpine:latest
ARG OVERLAY_VERSION="v2.2.0.3"
ARG OVERLAY_ARCH="amd64"
RUN apk add --no-cache --latest --virtual deps bash curl openvpn privoxy
ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}-installer /tmp/
RUN chmod +x /tmp/s6-overlay-${OVERLAY_ARCH}-installer && /tmp/s6-overlay-${OVERLAY_ARCH}-installer / && rm /tmp/s6-overlay-${OVERLAY_ARCH}-installer
ENV PRIVOXY_CONFIG=/etc/privoxy/config
ENV OVPN_CONFIG=/etc/openvpn/config.ovpn
ENV OVPN_CREDENTIALS=/etc/openvpn/credentials.txt
WORKDIR /
COPY root/ /
ENTRYPOINT ["/init"]
