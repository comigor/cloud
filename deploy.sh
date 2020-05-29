#!/bin/bash

source .env

userdata=$(cat cloud-config.yml \
    | gsed -E "s/__USERNAME__/$USERNAME/g" \
    | gsed -E "s/__NETWORK_NAME__/$NETWORK_NAME/g" \
    | gsed -E "s/__SSH_PUBLIC__/${SSH_PUBLIC//\//\\/}/g" \
    | gsed -E "s/__EMAIL__/$EMAIL/g" \
    | gsed -E "s/__ACME_EMAIL__/$ACME_EMAIL/g" \
    | gsed -E "s/__CF_APIKEY__/$CF_APIKEY/g" \
    | gsed -E "s/__GOOGLE_CLIENT_ID__/$GOOGLE_CLIENT_ID/g" \
    | gsed -E "s/__GOOGLE_CLIENT_SECRET__/$GOOGLE_CLIENT_SECRET/g" \
    | gsed -E "s/__SECRET__/$SECRET/g" \
    | gsed -E "s/__DOMAIN__/$DOMAIN/g" \
    | gsed -E "s/__SUBDOMAIN__/$SUBDOMAIN/g" \
    | gsed -E "s/__ZEROTIER_NETWORK_ID__/$ZEROTIER_NETWORK_ID/g" \
    | gsed -E "s/__PLEX_CLAIM__/$PLEX_CLAIM/g" \
    | gsed -E "s/__RCLONE_TOKEN__/${RCLONE_TOKEN//\//\\/}/g" \
    | gsed -E "s/__GDRIVE_CRYPT_PASS1__/$GDRIVE_CRYPT_PASS1/g" \
    | gsed -E "s/__GDRIVE_CRYPT_PASS2__/$GDRIVE_CRYPT_PASS2/g" \
    | gbase64 -w 0)

echo "$userdata" | pbcopy

source $HOME/Dropbox/Configuration/myaws
aws ec2 request-spot-fleet --spot-fleet-request-config file://<(cat aws_spot_config_cheap.json | sed "s/__USERDATA__/$userdata/g")
