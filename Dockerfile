FROM ruby:3.2.2

# Set environment variables
ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Set the working directory in the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets
RUN #bundle exec rails assets:precompile

# Start the Rails server
CMD ["bundle", "exec", "rails", "server"]
