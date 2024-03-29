FROM registry.hub.docker.com/library/nginx:1.19.1-alpine

ARG TARGETARCH
ENV TARGETARCH=$TARGETARCH

RUN version=$(curl -s -L https://api.github.com/repos/oauth2-proxy/oauth2-proxy/releases/latest | grep tag_name | grep -oe "v[0-9]\+.[0-9]\+.[0-9]\+") && \
	wget https://github.com/oauth2-proxy/oauth2-proxy/releases/download/${version}/oauth2-proxy-${version}.linux-${TARGETARCH}.tar.gz && \
	tar -xzvf oauth2-proxy-${version}.linux-${TARGETARCH}.tar.gz && \
	mv oauth2-proxy-${version}.linux-${TARGETARCH}/oauth2-proxy /oauth2-proxy && \
	rm -rf oauth2-proxy-${version}.linux-${TARGETARCH} && \
	rm oauth2-proxy-${version}.linux-${TARGETARCH}.tar.gz && \
	mv /docker-entrypoint.sh /docker-entrypoint-original.sh

COPY docker-entrypoint-with-oauth.sh /docker-entrypoint.sh
