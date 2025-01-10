#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid
rm -f /rails/tmp/pids/server.pid

# Run any pending migrations
echo "Running database setup..."
bundle exec rails db:create db:migrate
if [ "$RAILS_ENV" == "development" ]; then
  bundle exec rails db:seed
fi
echo "Finished database setup..."
# Execute the container's main process (set by CMD in the Dockerfile)
exec bundle exec "$@"
