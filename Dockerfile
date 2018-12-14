FROM ubuntu:bionic

LABEL maintainer="Daniel Bjørnådal <daniel@bjornadal.com>"

RUN set -x \
    && apt-get update \
    && apt-get -y install \
        exim4 \
        xtail

RUN rm -rf /etc/exim4 && mkdir -p /etc/exim4
ADD exim4.conf /etc/exim4/exim4.conf

ADD entrypoint.sh .
RUN chmod 755 /entrypoint.sh

ENV PRIMARY_HOST=example.com
ENV ALLOWED_HOSTS=0.0.0.0/0

# Remember to make this persistent
# VOLUME /var/spool/exim4

ENTRYPOINT ["/entrypoint.sh"]