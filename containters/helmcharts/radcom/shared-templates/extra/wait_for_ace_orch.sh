#!/bin/bash
#set -x
folder=$(dirname $0)
source ${folder}/shared_function.sh

wait_ingress_vip_from_conductor
current_ingress_vip=${RETURN_FROM_FUNCTION}


echo "Cheking that ace-orchestrator is up ..."
wait_for_ace_orch ${current_ingress_vip}
