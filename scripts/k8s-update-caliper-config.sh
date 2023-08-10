#!/bin/bash

# !TODO! Update hardcoded values

cd /home/ubuntu/hll3_opennebula

yq e -i '.test.rounds[1].rateControl.opts.tps = $1' /home/ubuntu/hll3_opennebula/caliper/benchmarks/simplesupplychain/config.yaml

cd /home/ubuntu/selfConfiguringFabric