#!/bin/bash

case "$1" in
  "rails")
    echo $DATABASE_HOST
    echo $DATABASE_PORT
    echo $DATABASE_PASSWORD
    echo $RAILS_ENV
    bundle exec rails db:migrate
    bundle exec rails s
    ;;
  "sidekiq")
    bundle exec rails db:migrate
    bundle exec sidekiq -C config/sidekiq.yml
    ;;
  *)
    exec "$@"
    ;;
esac
