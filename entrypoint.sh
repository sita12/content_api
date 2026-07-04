#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# DB migrate only for BE
if [ "$1" = 'bin/rails' ]; then
  # DB migrate
  echo "Executing DB MIGRATE ...."
  bundle exec rake db:migrate
  
  # DB seed
  echo "Executing DB SEED ...."
  bundle exec rake db:seed
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"