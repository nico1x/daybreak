#!/bin/sh

set -eu

# Bootstrap superadmin as needed
test_superuser='
from django.contrib.auth import get_user_model;
get_user_model().objects.get(username="admin");
'
create_superuser='
from django.contrib.auth import get_user_model;
get_user_model().objects.create_superuser(
    "admin", "admin@example.com", "admin"
);
'
if ! uv run manage.py shell -c "$test_superuser" 2>/dev/null; then
    uv run manage.py migrate
    uv run manage.py shell -c "$create_superuser"
fi

uv run manage.py runserver 0.0.0.0:8001