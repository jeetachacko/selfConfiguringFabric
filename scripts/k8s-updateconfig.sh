#!/usr/bin/env bash

# !TODO! Update hardcoded values
# sed -i "s/.*value:.*/    value: $2/" /home/ubuntu/hll3_opennebula/fabric/channel-update/values.yaml
# sed -i "s/.*pval:.*/    pval: $3/" /home/ubuntu/hll3_opennebula/fabric/channel-update/values.yaml
# sed -i "s/.*tval:.*/    tval: $4s/" /home/ubuntu/hll3_opennebula/fabric/channel-update/values.yaml
# sed -i "s/.*sval:.*/    sval: $5/" /home/ubuntu/hll3_opennebula/fabric/channel-update/values.yaml
#sed -i "s/.*tps.*/            tps: $6/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml

cd /home/ubuntu/hll3_opennebula
if [[ $1 == 50 ]]; then
  echo "Updating workload type and restarting caliper"
  sed -i "s/.*var workloadType.*/          var workloadType = 1/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  >/home/ubuntu/hll3_opennebula/tpsupdate.txt
  pkill -9 -f ./scripts/caliper_run.sh
  pkill -9 -f caliper-manager
  pkill -9 -f caliper-logs.txt
  sleep 60s
  while [ -f /home/ubuntu/hll3_opennebula/check_caliper.txt ]
  do
    echo "waiting for caliper restart..."
    sleep 300s
    echo "Delete check file"
    rm /home/ubuntu/hll3_opennebula/check_caliper.txt
  done
elif [[ $(($1 % 100)) == 0 ]]; then
  val=$(($1 / 100))
  echo "Updating workload type and restarting caliper"
  if [[ $(($val % 2)) == 0 ]]; then
    sed -i "s/.*var workloadType.*/          var workloadType = 1/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  else
    sed -i "s/.*var workloadType.*/          var workloadType = 0/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  fi

<<<<<<< HEAD
=======
if [[ $1 < 99 ]] && [[ $(($1 % 33)) == 0 ]]; then
  echo "Updating transaction rate and restarting caliper"
  >/home/ubuntu/hll3_opennebula/tpsupdate.txt
  pkill -9 -f ./scripts/caliper_run.sh
  pkill -9 -f caliper-manager
  pkill -9 -f caliper-logs.txt
  sleep 60s
  while [ -f /home/ubuntu/hll3_opennebula/check_caliper.txt ]
  do
    echo "waiting for caliper restart..."
    sleep 300s
    echo "Delete check file"
    rm /home/ubuntu/hll3_opennebula/check_caliper.txt
  done
elif [[ $(($1 % 100)) == 0 ]]; then
  echo "Updating transaction rate and restarting caliper"
>>>>>>> f9b6dda82a1e1e095e36d93f00448f3a9696d999
  >/home/ubuntu/hll3_opennebula/tpsupdate.txt
  pkill -9 -f ./scripts/caliper_run.sh
  pkill -9 -f caliper-manager
  pkill -9 -f caliper-logs.txt
  sleep 60s
  while [ -f /home/ubuntu/hll3_opennebula/check_caliper.txt ]
  do
    echo "waiting for caliper restart..."
    sleep 300s
    echo "Delete check file"
    rm /home/ubuntu/hll3_opennebula/check_caliper.txt
  done
fi

<<<<<<< HEAD
#Comment lines 35 to 48 for baseline run
echo "Updating function type and restarting caliper"
sed -i "s/.*var functionType.*/          var functionType = $2/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
>/home/ubuntu/hll3_opennebula/tpsupdate.txt
pkill -9 -f ./scripts/caliper_run.sh
pkill -9 -f caliper-manager
pkill -9 -f caliper-logs.txt
sleep 90s
while [ -f /home/ubuntu/hll3_opennebula/check_caliper.txt ]
do
  echo "waiting for caliper restart..."
  sleep 300s
  echo "Delete check file"
  rm /home/ubuntu/hll3_opennebula/check_caliper.txt
done



#./scripts/network_update.sh
=======

./scripts/network_update.sh
>>>>>>> f9b6dda82a1e1e095e36d93f00448f3a9696d999

# argo logs @latest | grep "max_message_count:" | tail -1 >> /home/ubuntu/hll3_opennebula/configvars.txt
# argo logs @latest | grep "preferred_max_bytes:" | tail -1 >> /home/ubuntu/hll3_opennebula/configvars.txt
# argo logs @latest | grep "BatchTimeout:" | tail -1 >> /home/ubuntu/hll3_opennebula/configvars.txt
# argo logs @latest | grep "snapshot_interval_size:" | tail -1 >> /home/ubuntu/hll3_opennebula/configvars.txt
# echo "" >> /home/ubuntu/hll3_opennebula/configvars.txt

#sleep 10s
#>/home/ubuntu/hll3_opennebula/check.txt

while [ -f /home/ubuntu/hll3_opennebula/check.txt ]
do
  echo "waiting for fabric & caliper restart..."
  sleep 300s
  echo "Delete check file"
  rm /home/ubuntu/hll3_opennebula/check.txt
done
echo "waiting for network update to take effect..."
sleep 240s

cd /home/ubuntu/selfConfiguringFabric
