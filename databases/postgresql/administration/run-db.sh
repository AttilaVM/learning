#!/bin/bash
set -e -u -o pipefail

password="$1"
port="$2"

test -d data || mkdir data

docker run -d \
    --name playground-postgres \
    --rm \
    -e POSTGRES_PASSWORD="$password" \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v data:/var/lib/postgresql/data \
    -p 7777:"$port" \
    postgres
