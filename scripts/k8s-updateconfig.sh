#!/usr/bin/env bash

##1==Baseline, 0==Learn
baseline=0

############################################################################################################
# #Comment for baseline
echo "Updating function type"
sed -i "s/.*var functionType.*/          var functionType = $2/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
baseline=0
############################################################################################################

cd /home/ubuntu/hll3_opennebula
if [[ $1 == 50 ]]; then
  echo "Updating workload type and restarting caliper"
  sed -i "s/.*var workloadType.*/          var workloadType = 1/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  >/home/ubuntu/hll3_opennebula/tpsupdate.txt
  if [[ $baseline == 1 ]]; then

    ## Comment for 01 baselines only. Dont comment for 00 baselines and learn
    # pkill -9 -f ./scripts/caliper_run.sh
    # pkill -9 -f caliper-manager
    # pkill -9 -f caliper-logs.txt
    # sleep 60s

    ## Comment for 00 baselines and learn. Dont comment for 01 baselines
    cd /home/ubuntu/hll3_opennebula
    >/home/ubuntu/hll3_opennebula/restart.txt
    pkill -9 -f ./scripts/caliper_run.sh
    pkill -9 -f caliper-manager
    pkill -9 -f caliper-logs.txt
    sleep 60s

  fi
elif [[ $(($1 % 100)) == 0 ]]; then
  val=$(($1 / 100))
  echo "Updating workload type and restarting caliper"
  if [[ $(($val % 2)) == 0 ]]; then
    sed -i "s/.*var workloadType.*/          var workloadType = 1/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  else
    sed -i "s/.*var workloadType.*/          var workloadType = 0/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  fi
  >/home/ubuntu/hll3_opennebula/tpsupdate.txt
  if [[ $baseline == 1 ]]; then
  
    ## Comment for 01 baselines only. Dont comment for 00 baselines and learn
    # pkill -9 -f ./scripts/caliper_run.sh
    # pkill -9 -f caliper-manager
    # pkill -9 -f caliper-logs.txt
    # sleep 60s

    ## Comment for 00 baselines and learn. Dont comment for 01 baselines
    cd /home/ubuntu/hll3_opennebula
    >/home/ubuntu/hll3_opennebula/restart.txt
    pkill -9 -f ./scripts/caliper_run.sh
    pkill -9 -f caliper-manager
    pkill -9 -f caliper-logs.txt
    sleep 60s
    
  fi
fi

if [ -f /home/ubuntu/hll3_opennebula/restart.txt ] || [ -f /home/ubuntu/hll3_opennebula/check.txt ]; then
  echo "waiting for fabric & caliper restart..."
  sleep 300s
  rm /home/ubuntu/hll3_opennebula/check.txt
  rm /home/ubuntu/hll3_opennebula/restart.txt
fi

if [[ $baseline == 0 ]]; then
  >/home/ubuntu/hll3_opennebula/tpsupdate.txt
  pkill -9 -f ./scripts/caliper_run.sh
  pkill -9 -f caliper-manager
  pkill -9 -f caliper-logs.txt
  sleep 60s
fi



if [ -f /home/ubuntu/hll3_opennebula/check_caliper.txt ]; then
  echo "waiting for caliper restart..."
  sleep 240s
  echo "Delete check file"
  rm /home/ubuntu/hll3_opennebula/check_caliper.txt
fi


echo "waiting for network update to take effect..."
sleep 240s

cd /home/ubuntu/selfConfiguringFabric
