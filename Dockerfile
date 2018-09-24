FROM ruby:2.5.1-alpine

LABEL name="jasonheecs/wiki-converter"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

ENV RACK_ENV dev
ENV MAIN_APP_FILE app.rb

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apk add --no-cache \
    bash='>=4.0.0' \
    bash-completion='>=2.0' \
    util-linux='>=2.0' \
    coreutils='>=8.0' \
    binutils='>=2.0' \
    findutils='>=4.0' \
    grep='>3.0'

# install build dependencies needed for certain Ruby gems in development group
RUN if [ "${RACK_ENV}" = "dev" ]; then \
        apk add --no-cache alpine-sdk='>=0.5'; \
    fi

WORKDIR /usr/src/app
COPY ./app .
RUN gem install bundler --version=1.16.5

CMD ["/bin/bash", "./startup.sh"]
