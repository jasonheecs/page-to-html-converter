ARG BUILD_ENV='dev'

FROM jasonheecs/alpine-ruby:1.0.1 AS base

LABEL name="jasonheecs/html-converter"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

ARG BUILD_ENV

ENV HOST_PORT 4567
ENV PORT 80
ENV APP_DIRECTORY /usr/src/app
ENV RACK_ENV=${BUILD_ENV}

RUN gem install bundler --version=1.16.5

# cache bundle install to speed up docker build
COPY ./app/Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --without development test -j 20


# Build Docker image for development
FROM base AS dev
RUN bundle config --delete without && bundle install -j 20


# Build Docker image for production
FROM base AS production
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Select the right image depending on environment
# hadolint ignore=DL3006
FROM ${BUILD_ENV} AS build
WORKDIR ${APP_DIRECTORY}
COPY ./app .


FROM build
CMD ["/bin/bash", "./startup.sh"]
