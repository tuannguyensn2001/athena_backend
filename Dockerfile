FROM ruby:3.2.2

ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV RACK_ENV=production

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get update && apt-get install -y supervisor


WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN #bundle exec rails assets:precompile

COPY entrypoint.sh /entrypoint.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
