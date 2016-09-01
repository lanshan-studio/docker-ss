FROM alpine:3.4

RUN buildDeps=" \
		build-base \
		curl \
		linux-headers \
		openssl-dev \
		tar \
		asciidoc \
		xmlto \
	"; \
	set -x \
	&& apk add --update openssl \
	&& apk add $buildDeps \
	&& curl -SL "https://github.com/shadowsocks/shadowsocks-libev/archive/v2.5.0.tar.gz" -o ss.tar.gz \
	&& mkdir -p /usr/src/ss \
	&& tar -xf ss.tar.gz -C /usr/src/ss --strip-components=1 \
	&& rm ss.tar.gz \
	&& cd /usr/src/ss \
	&& ./configure \
	&& make install \
	&& cd / \
	&& rm -fr /usr/src/ss \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/ss-server"]