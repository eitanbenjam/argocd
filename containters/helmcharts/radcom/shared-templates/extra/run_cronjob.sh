#!/bin/bash
cronjon_name=${RADCOM_CRONJOB_NAME}
if [ "X${cronjon_name}" == "X" ];then
	echo "RADCOM_CRONJOB_NAME env var should be set"
	exit 1
fi
exist=$(kubectl get cronjob | grep -w ^"service-access-config"|awk '{print $1}')
if [ "X${exist}" == "X" ];then
    echo -n "waiting from cronjob ${cronjon_name} .."
    while [ "X${exist}" == "X" ];do
      echo -n "."
      sleep 30
    done
fi
echo "cronjob ${cronjon_name} exist, will run it"	
kubectl create job --from=cronjob/${cronjon_name} ace-cd-${cronjon_name}

