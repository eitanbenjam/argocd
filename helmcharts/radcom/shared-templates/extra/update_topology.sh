#!/bin/bash
#set -x
folder=$(dirname $0)
source ${folder}/shared_function.sh
add_template='''
	{
		"name": "NAME_PLACEHOLDER",
		"site_name": "SITE_PLACEHOLDER",
		"type": "TYPE_PLACEHOLDER",
		"cluster": "CLUSTER_PLACEHOLDER",
		"node_count": "NODE_COUNT_PLACEHOLDER",
		"attributes": [
				{
					"name": "ip-eth0",
					"value": "IP_PLACEHOLDER"
				},
				{
					"name": "hostname",
					"value": "NAME_PLACEHOLDER"
				},
				{
					"name": "rprb_26071_oam_direct_net_1",
					"value": "IP_PLACEHOLDER"
				},
				{
					"name": "version_number",
					"value": "VERSION_PLACEHOLDER"
				},
				{
					"name": "rprb_26071_int_beinterconnect_net_1",
					"value": "IP_PLACEHOLDER"
				},
				{
					"name": "rprb_26071_cdr_direct_net_1",
					"value": "IP_PLACEHOLDER"
				},
				{
					"name": "oam_protected_net_ip_0",
					"value": "IP_PLACEHOLDER"
				},
				{
					"name": "rprb_26071_oam_protected_vip_0",
					"value": "VIRTUAL_PLACEHOLDER"
				},
				{
					"name": "rprb_26071_oam_direct_vip_1",
					"value": "VIRTUAL_PLACEHOLDER"
				}
        	]
        }
'''


#Adding site
echo ""
add_site


#Current
get_nodes_from_kubectl
echo ""
echo "$(date "+%D %H:%M:%S") INFO: Waiting for ingress"
get_ingress_vip
current_ingress_vip=${RETURN_FROM_FUNCTION}


#Topology
get_data_from_coductor $RADCOM_SITE $RADCOM_CLUSTER_NAME
get_ingress_vip_from_conductor
conductor_ingress_vip=${RETURN_FROM_FUNCTION}

echo SUMMERY:
echo "Real status"
echo "Real ingress vip:$current_ingress_vip"
for host in ${existing_nodes[@]};do 
	name=$(echo ${host}|awk -F',' '{print $1}')
	ip=$(echo ${host}|awk -F',' '{print $2}')
	echo "|${name}|${ip}|"
done

echo ""
echo "Conductor Topology status"

echo "Ingress vip in conductor: $conductor_ingress_vip"
for host in ${conductor_nodes[@]};do 
	name=$(echo ${host}|awk -F',' '{print $1}')
	ip=$(echo ${host}|awk -F',' '{print $2}')
	echo "|${name}|${ip}|"
done




get_ingress_vips
current_ingress_vips=${RETURN_FROM_FUNCTION}

if [ "X${conductor_ingress_vip}" == "X" ] || ( ! echo -w ${current_ingress_vips}| grep "${conductor_ingress_vip}" ) || [ ${coductor_node_count} -ne ${node_count} ];then
	echo "$(date "+%D %H:%M:%S") INFO: Topology changed !!!"
	current_ingress_vip=$(echo "${current_ingress_vip}"|xargs)
	#Removing
	for node in ${conductor_nodes[@]};do
	echo -e "\n\n"
       echo "Deleting Node:$node"
	   vm_id=$(echo $node|awk -F',' '{print $3}')
	   return_code=$(curl -s -o /dev/null -I -w "%{http_code}" -X DELETE http://${CONDUCTOR_IP}:8084/MaveriQConductor/removeMachine?vmId=${vm_id}&shutOffMachine=false)
	   if [ ${return_code} -eq 200 ];then
	   	echo "$(date "+%D %H:%M:%S") INFO: Node $node Deleted"
	   else
	    echo "$(date "+%D %H:%M:%S") ERROR: ${node} cant be deleted"
	   fi
	 
	   #curl -s -X DELETE http://${CONDUCTOR_IP}:8084/MaveriQConductor/removeMachine?vmId=${vm_id}&shutOffMachine=false
	done
	sleep 1
	curl -s http://${CONDUCTOR_IP}:8084/MaveriQConductor/readDbIp
	sleep 1
	echo "$(date "+%D %H:%M:%S") INFO: Start Adding nodes into topology"
	for node in "${existing_nodes[@]}";do
          if [ "X${node}" != "X" ];then
            node_name=$(echo $node|awk -F',' '{print $1}')
            node_ip=$(echo $node|awk -F',' '{print $2}')
			echo -e "\n\n"
            echo "***** Adding node: ${node_name}, Ip: ${node_ip}"
            create_node_template=$(echo ${add_template}| sed "s/VERSION_PLACEHOLDER/${RADCOM_VERSION}/g" | sed "s/TYPE_PLACEHOLDER/${RADCOM_MACHINE_TYPE}/g" | sed "s/CLUSTER_PLACEHOLDER/$RADCOM_CLUSTER_NAME/g" |sed "s/SITE_PLACEHOLDER/${RADCOM_SITE}/g" | sed "s/IP_PLACEHOLDER/${node_ip}/g"| sed "s/NAME_PLACEHOLDER/${node_name}/g"| sed "s/NODE_COUNT_PLACEHOLDER/${node_count}/g"| sed "s/VIRTUAL_PLACEHOLDER/${current_ingress_vip}/g")
            echo "$(date "+%D %H:%M:%S") INFO: Sending to: http://${RADCOM_CONDUCTOR_IP}:8084/MaveriQConductor/api/v2/machine/create"
			echo "Data:"
			echo ${create_node_template}
			if (eval curl -s -X POST  http://${RADCOM_CONDUCTOR_IP}:8084/MaveriQConductor/api/v2/machine/create -H \"Content-Type: application/json\" -d \'${create_node_template}\');then
				echo "$(date "+%D %H:%M:%S") INFO: Server ${node_name} Added"
			else
				echo "$(date "+%D %H:%M:%S") ERROR: Server ${node_name} was not added"
			fi
          fi
    done
	
	cronjob_name=${RADCOM_CRONJOB_NAME}
	if [ "X${cronjob_name}" == "X" ];then
			echo "$(date "+%D %H:%M:%S") WARN: RADCOM_CRONJOB_NAME env var should be set"	
			exit 0
	fi
	echo "$(date "+%D %H:%M:%S") INFO: Running cronjob ${cronjob_name}"
	exist=$(kubectl get cronjob | grep -w ^"${cronjob_name}"|awk '{print $1}')
	if [ "X${exist}" == "X" 	];then
		echo  "$(date "+%D %H:%M:%S") INFO: Waiting from cronjob ${cronjob_name} to be created"
		while [ "X${exist}" == "X" ];do
			sleep 30
			exist=$(kubectl get cronjob | grep -w ^"${cronjob_name}"|awk '{print $1}')
		done
		echo "$(date "+%D %H:%M:%S") INFO: cronjob ${cronjob_name} created"
	fi
	echo "$(date "+%D %H:%M:%S") INFO: cronjob ${cronjob_name} exist, will run it"
	if (kubectl get jobs | grep ^ace-cd-${cronjob_name});then
		kubectl delete job ace-cd-${cronjob_name} --wait
	fi
	if (kubectl get pods | grep -w ace-cd-${cronjob_name});then
		kubectl delete pod -l job-name=ace-cd-${cronjob_name} --wait
	fi 
	kubectl create job --from=cronjob/${cronjob_name} ace-cd-${cronjob_name}

else
	echo "$(date "+%D %H:%M:%S") INFO: Topology not changed"
fi






