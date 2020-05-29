#!/bin/bash
source helpers.sh
source $HOME/Dropbox/Configuration/myaws

userdata=$(replace_vars cloud-config.yml | gbase64 -w 0)

aws ec2 request-spot-fleet --spot-fleet-request-config file://<(cat aws_spot_config_cheap.json | sed "s/__USERDATA__/$userdata/g")
