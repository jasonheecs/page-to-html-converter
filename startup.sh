#!/bin/bash

if [ "${RACK_ENV}" == "production" ]; then
  bundle install --without development test -j 20
  ruby ${MAIN_APP_FILE} -p 80
else
  bundle install -j 20
  if [ "${RACK_ENV}" == "test" ]; then
    rspec
  else
#    ruby ${MAIN_APP_FILE} -p 80 -o '0.0.0.0'
#    bundle exec rerun "ruby ${MAIN_APP_FILE} -p 80 -o '0.0.0.0'"
    bundle exec rerun "ruby ${MAIN_APP_FILE} -p 80"
  fi
fi
