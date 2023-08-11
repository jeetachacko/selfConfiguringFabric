#!/usr/bin/env bash

# !TODO! Update hardcoded values

#TODO: Add sed key also
sed -i "s/.*value:.*/    value: $1/" /home/ubuntu/hll3_opennebula/fabric/channel-update/values.yaml

cd /home/ubuntu/hll3_opennebula

./scripts/network_update.sh

sleep 20s

cd /home/ubuntu/selfConfiguringFabric