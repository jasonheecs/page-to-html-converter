#!/bin/bash

echo "Current environment is ${RACK_ENV}"

if [ "${RACK_ENV}" == "production" ]; then
  rackup -p "${PORT}"
else
  if [ "${RACK_ENV}" == "test" ]; then
    rspec
  else
    bundle exec rerun "rackup -p ${PORT}" >rerun.log 2>&1
  fi
fi
