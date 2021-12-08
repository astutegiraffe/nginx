FROM registry.hub.docker.com/library/nginx:1.19.1-alpine

ARG TARGETARCH
ENV TARGETARCH=$TARGETARCH

RUN wget https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.1.3/oauth2-proxy-v7.1.3.linux-${TARGETARCH}.tar.gz && \
	tar -xzvf oauth2-proxy-v7.1.3.linux-${TARGETARCH}.tar.gz && \
	mv oauth2-proxy-v7.1.3.linux-${TARGETARCH}/oauth2-proxy /oauth2-proxy && \
	rm -rf oauth2-proxy-v7.1.3.linux-${TARGETARCH} && \
	rm oauth2-proxy-v7.1.3.linux-${TARGETARCH}.tar.gz && \
	mv /docker-entrypoint.sh /docker-entrypoint-original.sh

COPY docker-entrypoint-with-oauth.sh /docker-entrypoint.sh
