#!/bin/bash



be="aws-nginx-ingress bp-k8s-infra bp-ace-cd bp-oam bp-oam-agent bp-monitoring-tools bp-network-analytics bp-analyzer-infra bp-session-analyzer bp-packet-analyzer bp-event-bus bp-application-be bp-applications bp-online-db bp-object-storage bp-adminapp-be bp-admin-applications bp-aim bp-automation-infra-cdf"
#be="bp-k8s-infra bp-oam bp-oam-agent"

#be="bp-oam bp-oam-agent bp-monitoring-tools bp-network-analytics bp-analyzer-infra bp-session-analyzer bp-packet-analyzer bp-event-bus bp-application-be bp-applications bp-online-db bp-object-storage bp-adminapp-be bp-admin-applications bp-aim bp-automation-infra-cdf"
fe="bp-k8s-infra bp-oam-agent-cdf bp-monitoring-tools-cdf bp-probe bp-probe-lb bp-probe-lb-agent bp-ran-probe-a bp-ran-probe-b"

type=$1

if [ "X${type}" == "Xbe" ];then
	arr=($(echo "${be}"))
elif [ "X${type}" == "Xfe" ];then
	arr=($(echo "${fe}"))
else
	echo "unknown type ${mode}"
	exit 1
fi
for  b in "${arr[@]}";do
	echo "Launch app $b"
	cd applications/$b
	kubectl create -f argo_manifast.yaml  -n argocd
	cd -
	sleep 2
done



#for b in `argocd app list | awk '{print $1}'|grep -v NAME|grep -v argocd/bp-k8s-infra`;do argocd app delete $b -y;argocd app  terminate-op $b;done
