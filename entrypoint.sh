#!/bin/bash

case "$1" in
  "rails")
    echo $DATABASE_HOST
    echo $DATABASE_PORT
    echo $DATABASE_PASSWORD
    echo $RAILS_ENV
    bundle exec rails db:migrate
    /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
#    bundle exec rails s
    ;;
  "test")
      echo $DATABASE_HOST
      echo $DATABASE_PORT
      echo $DATABASE_PASSWORD
      echo $RAILS_ENV
      echo $DATABASE_USR
      bundle exec rails db:setup
      bundle exec rspec
    ;;
  "sidekiq")
    bundle exec rails db:migrate
#    bundle exec sidekiq
    ;;
  *)
    exec "$@"
    ;;
esac
