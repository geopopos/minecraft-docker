FROM alpine:latest
MAINTAINER George Roros

ENV INSTALL_PATH /lightweight_server
RUN mkdir -p $INSTALL_PATH
RUN apk --update add openjdk8-jre

WORKDIR $INSTALL_PATH

COPY . .
