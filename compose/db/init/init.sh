#!/bin/bash

psql -U $POSTGRES_USER -v ONERROR_STOP=1 <<-EOF
    CREATE EXTENSION pgcrypto;
EOF
