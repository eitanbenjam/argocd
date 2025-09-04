#!/bin/bash
#set -x
folder=$(dirname $0)
source ${folder}/shared_function.sh

echo "$(date "+%D %H:%M:%S") INFO: Getting Repository from conductor with version ${RADCOM_VERSION}"
repo_ip=$(curl http://${RADCOM_CONDUCTOR_IP}:8084/MaveriQConductor/api/v2/getSiteMachines?machineType=softwareRepository|jq -r ".[] | select(.installedVersion == \"${RADCOM_VERSION}\").attributes.rprb_26071_oam_direct_net_1"|xargs)

echo "$(date "+%D %H:%M:%S") INFO: ${RADCOM_VERSION} softwareRepository ip:${repo_ip}"
echo "$(date "+%D %H:%M:%S") INFO: Waiting for ingress ..."
wait_ingress_vip_from_conductor
current_ingress_vip=${RETURN_FROM_FUNCTION}

data="{\"Version\": \"${RADCOM_VERSION}\", \"Repository\": \"${repo_ip}\"}"
#eval curl -X POST  http://${current_ingress_vip}/orchestrator/v1/addVersionBlueprints -H \"Content-Type: application/json\" -d \'${data}\'


echo "$(date "+%D %H:%M:%S") INFO: Adding Blueprints ..."
added=false
while [ ${added} == 'false' ];do
  return_code=$(eval curl -s -o /dev/null  -w "%{http_code}" -X POST  http://${current_ingress_vip}/orchestrator/v1/addVersionBlueprints -H \"Content-Type: application/json\" -d \'${data}\')
  if [ ${return_code} -eq 200 ];then
        echo "$(date "+%D %H:%M:%S") INFO: Blueprint was added"
        added=true
  else
        echo -n "."
        sleep 30
  fi
done
