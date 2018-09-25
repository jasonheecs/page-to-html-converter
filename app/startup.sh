#!/bin/bash

echo "Current environment is ${RACK_ENV}"

if [ "${RACK_ENV}" == "production" ]; then
  rackup -p 80
else
  if [ "${RACK_ENV}" == "test" ]; then
    rspec
  else
    bundle exec rerun "rackup -p 80" >rerun.log 2>&1
  fi
fi
