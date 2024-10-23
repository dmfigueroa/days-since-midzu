#!/bin/bash

set -e

php artisan optimize
php artisan view:cache


# Run a command or start server
if [ $# -gt 0 ];then
    # If we passed a command, run it
    exec "$@"
else
    # Otherwise, attempt to migrate and then start the server
    php artisan migrate --force
    php artisan serve --host=0.0.0.0 --port=8080
fi
