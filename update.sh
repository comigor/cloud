#!/bin/bash
set -eu
source helpers.sh

IP=$1

TEMP_DOCKER_COMPOSE_FILE=$(mktemp)
TEMP_TRAEFIK_CONFIG_FILE=$(mktemp)

replace_vars docker-compose.yml > $TEMP_DOCKER_COMPOSE_FILE
replace_vars traefik.yml > $TEMP_TRAEFIK_CONFIG_FILE

scp $TEMP_DOCKER_COMPOSE_FILE $USERNAME@$IP:/shared/config/$SUBDOMAIN/docker-compose.yml
scp $TEMP_TRAEFIK_CONFIG_FILE $USERNAME@$IP:/shared/config/traefik/traefik.yml

ssh $USERNAME@$IP "cd /shared/config/$SUBDOMAIN ; bash -c 'docker-compose down && docker-compose up -d'"
