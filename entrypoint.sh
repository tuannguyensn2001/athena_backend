#!/bin/bash

case "$1" in
  "rails")
    bundle exec rails db:migrate
    bundle exec puma
    ;;
  "sidekiq")
    bundle exec rails db:migrate
    bundle exec sidekiq -C config/sidekiq.yml
    ;;
  *)
    exec "$@"
    ;;
esac
