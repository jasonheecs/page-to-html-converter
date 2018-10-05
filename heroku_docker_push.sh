#!/usr/bin/env bash

docker build --build-arg BUILD_ENV=production -t registry.heroku.com/page-to-html/web .
docker push registry.heroku.com/page-to-html/web
imageId=$(docker inspect registry.heroku.com/page-to-html/web --format='{{.Id}}')
payload='{"updates":[{"type":"web","docker_image":"'"$imageId"'"}]}'

# Release new image via Heroku's API
curl -n -X PATCH https://api.heroku.com/apps/page-to-html/formation \
-d "${payload}" \
-H "Content-Type: application/json" \
-H "Accept: application/vnd.heroku+json; version=3.docker-releases" \
-H "Authorization: Bearer ${HEROKU_TOKEN}"