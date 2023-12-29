#!/bin/bash

ENV_NAME=datascience-infra

# Infer project root
if [ ! -z $ZSH_NAME ]; then
  envFileName=$(print "${(%):-%x}")
elif [ ! -z $BASH ];then
  envFileName=$(echo "${BASH_SOURCE[0]}")
fi
export PROJECT_ROOT="$(realpath $(dirname $envFileName))"

source $PROJECT_ROOT/.$USER-env.sh

export PATH=$(cat << EOF | grep -v '^#' | tr -d '\n'
$PROJECT_ROOT/cli-tools/etl:
$PROJECT_ROOT/cli-tools/chemistry:
$PROJECT_ROOT/cli-tools/report:
$PROJECT_ROOT/scripts:
$PATH
EOF
)

export ETL_DATADIR=/mnt/data-01/shared/drug-repositioning
# Database connection
echo "Write posgresql user: $DATABASE_USER password (the prompt is invisible):"
read -s password

export PGPASSWORD=$password
export DATABASE_ADDR="10.100.120.151"
export DATABASE_PORT="5432"
export DATABASE_NAME="pagila"
export DATABASE_TYPE="postgresql"
export DATABASE_DRIVER="postgres_utf8"

export PGDATABASE="$DATABASE_NAME"
export PGUSER="$DATABASE_USER"
export PGHOST="localhost"

# neo4j
export NEO4J_AUTH="neo4j/${password}"

export COMPOUND_REPORT_TEMPLATE="$PROJECT_ROOT/report-templates/compound-cards.html"

echo "Write Active Directory user password (the prompt is invisible):"
read -s password
export KERBEROS_USER=attila.molnar
export KERBEROS_PASSWD=$password
ms-ml-start() {
  docker run \
    --network host \
    --rm \
    -v "$PROJECT_ROOT/notebooks:/usr/app/notebooks" \
    --env KERBEROS_USER="$KERBEROS_USER" \
    --env KERBEROS_PASSWD="$KERBEROS_PASSWD" \
    -it \
    ms-ml-jupyter:v0.1
}

ms-ml-bash() {
  docker run \
    --network host \
    --rm \
    -v "$PROJECT_ROOT/notebooks:/usr/app/notebooks" \
    --env KERBEROS_USER="$KERBEROS_USER" \
    --env KERBEROS_PASSWD="$KERBEROS_PASSWD" \
    -it \
    ms-ml-jupyter:v0.1 \
    bash
}
