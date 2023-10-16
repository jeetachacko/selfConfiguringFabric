#!/usr/bin/env bash

# !TODO! Update hardcoded values
#[100, 100, 100, 100, 100, 100, 100, 100, 100, 100]
#[60, 60, 60, 60, 60, 60, 60, 60, 60, 60]

a="("
b=","
c=")"
d=","
e="["
f="]"

#tps=(500 300 1000 300 1000 500)

tps300=(30 30 30 30 30 30 30 30 30 30)
tps1000=(100 100 100 100 100 100 100 100 100 100)
tps500=(50 50 50 50 50 50 50 50 50 50)

#!!!!!! COMMENT LEARNEDRATE UPDATE FOR NONBASELINES !!!!!
echo "STEP COUNT IN UPDATEADMNRATES.SH $1"
if [[ $1 < 99 ]] && [[ $(($1 % 33)) == 0 ]]; then
  echo "Updating real transaction rate of caliper clients"
  >/home/ubuntu/hll3_opennebula/rlupdate.txt
  if [[ $(($1 / 33)) == 1 ]]; then
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps300[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  elif [[ $(($1 / 33)) == 2 ]]; then  
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps1000[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  fi
#tps=(500 300 1000 300 1000 500)
elif [[ $(($1 % 100)) == 0 ]] && [[ $1 != 0 ]]; then
  echo "Updating real transaction rate of caliper clients"
  >/home/ubuntu/hll3_opennebula/rlupdate.txt
  if [[ $(($1 / 100)) == 1 ]]; then
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps300[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  elif [[ $(($1 / 100)) == 2 ]]; then  
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps1000[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  elif [[ $(($1 / 100)) == 3 ]]; then  
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps500[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  elif [[ $(($1 / 100)) == 4 ]]; then  
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps500[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  elif [[ $(($1 / 100)) == 5 ]]; then  
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps300[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  elif [[ $(($1 / 100)) == 6 ]]; then  
    echo "Updating real transaction rate of caliper clients"
    printf -v tpsstr '%s, ' "${tps1000[@]}"
    tpsstr=${tpsstr/%" "/}
    tpsstr=${tpsstr/%$d/}
    tpsstr="[${tpsstr}]"
    echo $tpsstr
    sed -i "s/.*var wactualrate = .*/          var wactualrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
    sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $tpsstr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js
  fi

fi

# ======================================================================================================
# UNCOMMENT TO UPDATE ADMISSION RATES; COMMENT TO ONLY UPDATE REAL TRANSACTION RATES (BASELINE)
# $2 = 0.5 implies no change, 0 implies 10% decrease, 1 implies 10% increase
#learneddecision="(0, 0, 1, 0.5, 0, 1, 0.5, 0, 0, 0)"
learneddecision=$2
learneddecision=${learneddecision/$a/}
learneddecision=${learneddecision/$c/}
learneddecision=${learneddecision//$b/}
decisionarr=($learneddecision)
echo ${decisionarr[@]}

#learnedrate="[60, 60, 60, 60, 60, 100, 60, 60, 60, 60]"
learnedrate=$(cat /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js | grep 'wlearnedrate' |  awk '{ for (i=4; i<=13;i++){ {printf $i} {printf " "} } }' )
learnedrate=${learnedrate/$e/}
learnedrate=${learnedrate/$f/}
learnedrate=${learnedrate//$b/}
ratearr=($learnedrate)
echo ${ratearr[@]}

#actualrate="[60, 60, 60, 60, 60, 100, 60, 60, 60, 60]"
actualrate=$(cat /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js | grep 'wactualrate' |  awk '{ for (i=4; i<=13;i++){ {printf $i} {printf " "} } }')
actualrate=${actualrate/$e/}
actualrate=${actualrate/$f/}
actualrate=${actualrate//$b/}
actualratearr=($actualrate)
echo ${actualratearr[@]}

arrlength=${#ratearr[@]}
#multiplier=$(( 10/100 ))

# 0.5 implies no change, 0 implies 10% decrease, 1 implies 10% increase
# 10% increase only if new rate is less than actual rate - else no change
# 10% decrease only if new rate is greater than 70% of actual rate - else no change
 
# for (( i=0; i<arrlength; i++ ));
# do
#   if [ $i -lt 5 ]; then
#     index=0
#   else 
#     index=1
#   fi
#   printf "Index %d RateValue %s DecisionValue %s\n" $i "${ratearr[$i]}" "${decisionarr[$i]}"
#   if [ ${decisionarr[$index]} == 0 ]; then
#     decreaselimit=$(( ${actualratearr[$i]} * 70 / 100 ))
#     tempd=$(( ${ratearr[$i]} - ${ratearr[$i]} / 10 ))
#     if [ $tempd -gt $decreaselimit ]; then
#       ratearr[$i]=$tempd
#     else
#       ratearr[$i]=$decreaselimit
#       printf "Least possible value"
#     fi
#   elif [ ${decisionarr[$index]} == 1 ]; then
#     temp=$(( ${ratearr[$i]} + ${ratearr[$i]} / 10 ))
#     if [ $temp -lt ${actualratearr[$i]} ]; then
#       ratearr[$i]=$temp
#     else
#       ratearr[$i]=${actualratearr[$i]}
#       printf "Max possible value"
#     fi
#   else
#     printf "No change"
#   fi
# done

for (( i=0; i<arrlength; i++ ));
do
  if [ $i -lt 5 ]; then
    index=0
  else 
    index=1
  fi
  printf "Index %d RateValue %s DecisionValue %s\n" $i "${ratearr[$i]}" "${decisionarr[$i]}"
  if [ ${decisionarr[$index]} == 0 ]; then
    tempd=$(( ${actualratearr[$i]} * 80 / 100 ))
    ratearr[$i]=$tempd
  elif [ ${decisionarr[$index]} == 1 ]; then
    tempd=$(( ${actualratearr[$i]} * 70 / 100 ))
    ratearr[$i]=$tempd
  else
    ratearr[$i]=${actualratearr[$i]}
  fi
done



echo ${ratearr[@]}

printf -v ratestr '%s, ' "${ratearr[@]}"
ratestr=${ratestr/%" "/}
ratestr=${ratestr/%$d/}
ratestr="[${ratestr}]"
echo $ratestr

sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $ratestr/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js

cd /home/ubuntu/hll3_opennebula

echo "Updating admission rates and restarting caliper"
>/home/ubuntu/hll3_opennebula/rlupdate.txt
pkill -9 -f ./scripts/caliper_run.sh
pkill -9 -f caliper-manager
pkill -9 -f caliper-logs.txt
sleep 90s

#sleep 10s
#>/home/ubuntu/hll3_opennebula/check.txt

# ======================================================================================================

# Lines 155 to 163 (till sleep 120s) are always required

while [ -f /home/ubuntu/hll3_opennebula/check.txt ]
do
  echo "waiting for fabric & caliper restart..."
  sleep 300s
  echo "Delete check file"
  rm /home/ubuntu/hll3_opennebula/check.txt
done
echo "waiting for network update to take effect..."
sleep 240s


###NOT REQUIRED EVER

#read blockchain and get per client successrates and jains fairness index
# cd /home/ubuntu/hll3_opennebula/caliper/readBlockchain
# rm data/*
# rm data/csv/*
# kubectl port-forward svc/hlf-ca--org1 7054:7054 -n default &
# kubectl port-forward svc/hlf-peer--org1--peer0 7051:7051 -n default &
# node read_blockchain.js
# python3 convert_to_csv.py
# python3 calculate.py
# pkill -9 -f port-forward
# pkill -9 -f port-forward
# pkill -9 -f port-forward
# sleep 30s
# cd /home/ubuntu/selfConfiguringFabric
