#!/bin/bash
#Conductor DistributedLock general .git k8sRepository Kafka Kuberiq Kuberiq_CDF networks Processing QRouter RpmRepository SettingsAndHealthDB Storage Storage_by_host Vertica vLB vLBAgent vms_template vProbe
arr=("Conductor" "SettingsAndHealthDB" "Kafka" "Processing" "QRouter" "Vertica")
#arr=("Conductor" "SettingsAndHealthDB" "Kafka" "Processing" "QRouter" )

mode=$1
if [ "$mode" == "install" ] || [ "$mode" == "delete" ];then

	for c in "${arr[@]}  ";do
		echo Running $c
		name=$(echo $c|tr '[:upper:]' '[:lower:]')
		cd $c
		if [ "$mode" == "install" ];then
			argocd app create -f argo_manifast.yaml
		else
			argocd app delete  openshift-gitops-operator/${name} -y
		fi
		cd ..

	done
else
	echo "$mode not supported"
        exit 1
fi

