ARG BUILD_ENV='dev'

FROM ruby:2.5.1-alpine AS base

LABEL name="jasonheecs/html-converter"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

ARG BUILD_ENV

ENV APP_DIRECTORY /usr/src/app
ENV RACK_ENV=${BUILD_ENV}

RUN apk add --no-cache \
    bash='>=4.0.0' \
    bash-completion='>=2.0' \
    util-linux='>=2.0' \
    coreutils='>=8.0' \
    binutils='>=2.0' \
    findutils='>=4.0' \
    grep='>3.0' \
    build-base='>=0.4' && \
    gem install bundler --version=1.16.5

# cache bundle install to speed up docker build
COPY ./app/Gemfile* /tmp/
WORKDIR /tmp
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle install --without development test -j 20 && \
    bundle config --global frozen 1


# Build Docker image for development
FROM base AS dev
RUN bundle config --delete without && bundle install -j 20


# Build Docker image for production
FROM base AS production

# Select the right image depending on environment
# hadolint ignore=DL3006
FROM ${BUILD_ENV} AS build
WORKDIR ${APP_DIRECTORY}
COPY ./app .


FROM build
CMD ["/bin/bash", "./startup.sh"]
