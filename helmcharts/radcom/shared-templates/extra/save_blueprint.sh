#!/bin/bash
folder=$(dirname $0)
source ${folder}/shared_function.sh
wait_ingress_vip_from_conductor
current_ingress_vip=${RETURN_FROM_FUNCTION}

wait_for_ace_orch ${current_ingress_vip}
versions=""

while [ "X${versions}" == "X" ];do
    versions=$(eval curl -X POST 'http://${current_ingress_vip}/orchestrator/v1/getBlueprints' -H \"Content-Type: application/json\" -d  '{}' |jq ".[] | select(.blueprintType == \"${RADCOM_DEPLOYMENTNAME}\").version"|xargs)
    if [ "X${versions}" == "X" ];then
        echo "$(date "+%D %H:%M:%S") INFO: Waiting for blueprints to be added"
        sleep 30
        versions=$(eval curl -X POST 'http://${current_ingress_vip}/orchestrator/v1/getBlueprints' -H \"Content-Type: application/json\" -d  '{}' |jq ".[] | select(.blueprintType == \"${RADCOM_DEPLOYMENTNAME}\").version"|xargs)
    fi
done


if ( echo "${versions}" | grep -w ${RADCOM_VERSION});then
	echo "Version ${RADCOM_VERSION} exist in conductor, saving blueprint"
    python3 ${folder}/save_blueprint.py  --ingress_address ${current_ingress_vip}  --value_file /values/values --site_name ${RADCOM_SITE} --deployment_version ${RADCOM_VERSION} --deployment_name ${RADCOM_DEPLOYMENTNAME} --cs_name ${RADCOM_DEPLOYMENTNAME}
else
    echo "Pod is in version ${RADCOM_VERSION}, existing version in conductor are:${versions}"
    exit 1
fi

