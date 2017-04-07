FROM alpine
#MAINTAINER xjdata , <xjdata@gmail.com>

ENV SERVER_ADDR www.google.com
ENV SERVER_PORT 443
ENV PASSWORD    helloworld
ENV METHOD      chacha20
ENV PROTOCOL    auth_sha1_v4
ENV OBFS        tls1.2_ticket_auth
ENV TIMEOUT     300
ENV DNS_ADDR    8.8.8.8
ENV DNS_ADDR_2  8.8.4.4
ENV LOCAL_ADDR  127.0.0.1
ENV LOCAL_PORT  1080
ENV TIMEOUT     60


RUN apk update \
    && apk add python \
    libsodium \
    unzip \
    wget \
  && rm -rf /var/cache/apk/*



RUN wget --no-check-certificate https://github.com/breakwa11/shadowsocks/archive/manyuser.zip -O /tmp/manyuser.zip \
    && unzip -d /tmp /tmp/manyuser.zip \
    && mv /tmp/shadowsocksr-manyuser/shadowsocks ~/shadowsocks \
    && rm -rf /tmp/*


WORKDIR ~/shadowsocks


CMD python ~/shadowsocks/local.py \
              -s "$SERVER_ADDR" \
              -p "$SERVER_ADDR" \
              -b "$LOCAL_ADDR"  \
              -l "$LOCAL_PORT"  \
              -m "$METHOD"      \
              -k "$PASSWORD"    \
              -O "$PROTOCOL"    \
              -o "$OBFS"    \
              -t "$TIMEOUT"     \
              --fast-open
