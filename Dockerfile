FROM debian:stretch-backports
MAINTAINER Sebastien DOIDO <s.doido@gmail.com>

ARG application_version

COPY resources /tmp/resources
RUN /tmp/resources/build && rm -rf /tmp/resources

WORKDIR /app

CMD ["build-package"]
