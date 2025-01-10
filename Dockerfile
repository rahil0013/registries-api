# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.1
FROM docker.io/library/ruby:$RUBY_VERSION-slim

WORKDIR /rails

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    PATH="/usr/local/bundle/bin:$PATH"

# Install bundler
RUN gem install bundler

# Add Gemfile first for caching
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add application files
COPY . .

# Add and set permissions for the entrypoint script
COPY entrypoint.sh /rails/entrypoint.sh
RUN chmod +x /rails/entrypoint.sh

# Define entrypoint and command
ENTRYPOINT ["/rails/entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
