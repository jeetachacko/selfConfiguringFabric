#!/bin/bash

# !TODO! Update hardcoded values

cd /home/ubuntu/hll3_opennebula

./home/ubuntu/hll3_opennebula/scripts/caliper_delete.sh

sleep 10s

./home/ubuntu/hll3_opennebula/scripts/caliper_run.sh simplesupplychain

cd /home/ubuntu/selfConfiguringFabric