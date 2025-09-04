function get_ip_mode_str {
   str=$1
   if ( echo $str|grep -e '^.*\:.*\:.*$');then
	   echo "[${str}]"
   else
	   echo "${str}"
   fi
}

function get_data_from_coductor {
        site=$1
        cluster_name=$2
        wait_for_conductor
        if ( ! curl -s "http://${CONDUCTOR_IP}:8084/MaveriQConductor/api/v1/getMachineProperties?siteName=${site}&clusterName=${cluster_name}"  > /tmp/site_info);then
                echo "cant conect to condutor"
                exit 1
        fi

        cat /tmp/site_info | jq -r '.[] | "\(.name),\(.attributes.rprb_26071_oam_direct_net_1),\(.vmId)"' > /tmp/conductor_nodes
        conductor_vip=$(cat /tmp/site_info |jq -r ".[0].attributes.rprb_26071_oam_direct_vip_1")
        conductor_nodes=($(cat /tmp/conductor_nodes))
        coductor_node_count=$(echo "${conductor_nodes[@]}"|wc -w)
}

function get_nodes_from_kubectl {
        if ( ! kubectl get nodes -o wide | grep -v ^NAME | awk '{print $1","$6}' > /tmp/existing_nodes);then
                echo "Cant run kubectl get nodes"
                exit 1
        fi
        existing_nodes=($(cat /tmp/existing_nodes))
        node_count=$(echo "${existing_nodes[@]}" | wc -w)
}

function get_ingress_vip {
        if [ "X${RADCOM_INGRESS_IP}" == "X" ];then
                get_ingress_vips
                vips_arr=${RETURN_FROM_FUNCTION}
                current_vip=$(echo $vips_arr|awk '{print $1}')
                echo "INGRESS IP: ${current_vip}"
                RETURN_FROM_FUNCTION=$current_vip
        else
               echo "$(date "+%D %H:%M:%S") INFO: Returning ingress ip ${RADCOM_INGRESS_IP} from environment var"
               RETURN_FROM_FUNCTION=${RADCOM_INGRESS_IP}
        fi
}



function get_ingress_type {
        echo "$(date "+%D %H:%M:%S") INFO: Get_ingress_type: Waiting for ingress service to be created"
        local currect_vip_type=$(kubectl get svc -n ingress-nginx -o json| jq '.items[] | select(.metadata.name == "ingress-nginx-controller").spec.type'|xargs)
        while [ "X${currect_vip_type}" == "X" ];do
        sleep 10
        local currect_vip_type=$(kubectl get svc -n ingress-nginx -o json| jq '.items[] | select(.metadata.name == "ingress-nginx-controller").spec.type'|xargs)
        done
        echo "$(date "+%D %H:%M:%S") INFO: Found ingress type: ${currect_vip_type}"
        RETURN_FROM_FUNCTION=${currect_vip_type}
}


function get_ingress_vip_by_service {
        currect_vip_type=$1
        if [ ${currect_vip_type} == "LoadBalancer" ];then
                local current_vip_addr=$(kubectl get svc -n ingress-nginx -o json| jq '.items[] | select(.metadata.name == "ingress-nginx-controller").status.loadBalancer.ingress[0].hostname // .status.loadBalancer.ingress[0].ip'|xargs)
        elif [ ${currect_vip_type} == "ClusterIP" ];then
                local current_vip_addr=$(kubectl get svc -n ingress-nginx -o json| jq '.items[] | select(.metadata.name == "ingress-nginx-controller").spec'.${currect_vip_type} |xargs)
        else
                echo "$(date "+%D %H:%M:%S") ERROR:  ingress service type ${currect_vip_type} unknown."
                exit 1 
        fi
        echo "$(date "+%D %H:%M:%S") INFO: Found ingress ip ${current_vip_addr} for ingress type: ${currect_vip_type}"
        RETURN_FROM_FUNCTION=${current_vip_addr}
                

}

function get_ingress_vips {
        echo "$(date "+%D %H:%M:%S") INFO: Get_ingress_vips: Getting ingress type"
        get_ingress_type
        currect_vip_type=${RETURN_FROM_FUNCTION}
        
        found="false"

        while [ $"X${found}" == "Xfalse" ];do
                #local current_vip_addr=$(kubectl get svc -n ingress-nginx | grep -w ^"ingress-nginx-controller "|awk '{print $4}')
                get_ingress_vip_by_service ${currect_vip_type}
                local current_vip_addr=${RETURN_FROM_FUNCTION}
                        
                if [ "X${current_vip_addr}" != "X" ] && [ "X${current_vip_addr}" != "X<pending>" ] && [ "X${current_vip_addr}" != "Xnull" ];then
                        echo "$(date "+%D %H:%M:%S") INFO: Found DNS: ${current_vip_addr}, Type is: ${currect_vip_type}"
                        echo  "$(date "+%D %H:%M:%S") INFO: Waiting for ${current_vip_addr} will be resolved"
                        current_vip=$(python3 -c "import socket;print(socket.gethostbyname_ex(\"${current_vip_addr}\")[2])")
                        while [ $"X${current_vip}" == "X" ];do
                                echo -n "."
                                sleep 10
                                current_vip=$(python3 -c "import socket;print(socket.gethostbyname_ex(\"${current_vip_addr}\")[2])")
                        done
                        current_vip=$(echo $current_vip | sed "s/\[//g" | sed "s/]//g" |sed "s/,//"| xargs)
                        echo "$(date "+%D %H:%M:%S") INFO: INGRESS IPS: ${current_vip}"
                        found="true"
                else
                        echo "$(date "+%D %H:%M:%S") WARNING: ingress vip output is: ${current_vip_addr}" 
                        sleep 10
                fi
        done
        RETURN_FROM_FUNCTION=$current_vip
}


function wait_ingress_vip_from_conductor {
 get_ingress_vip_from_conductor
 current_vip=${RETURN_FROM_FUNCTION}
 while [ "X${current_vip}" == "X" ];do
   sleep 30
   get_ingress_vip_from_conductor
   current_vip=${RETURN_FROM_FUNCTION}
 done
 echo "$(date "+%D %H:%M:%S") INFO: Kuberiq vip is: ${current_vip}"
 RETURN_FROM_FUNCTION=${current_vip}
}

function get_ingress_vip_from_conductor {
 echo "Trying to fetch kuberiq from conductor, using url:  http://${RADCOM_CONDUCTOR_IP}:8084/MaveriQConductor/api/v1/getClusterProperties"
 current_vip=$(curl -s http://${RADCOM_CONDUCTOR_IP}:8084/MaveriQConductor/api/v1/getClusterProperties | jq  ".[] | select(.type == \"kuberiq\") | select(.site == \"${RADCOM_SITE}\") | .attributes.rprb_26071_oam_direct_vip_1" | xargs)
 if [ "X${current_vip}" == "X" ];then
        echo "$(date "+%D %H:%M:%S") WARN: Kuberiq vip not found in conductor"
 else
        echo "$(date "+%D %H:%M:%S") INFO: Kuberiq vip is: ${current_vip}"        
fi
 RETURN_FROM_FUNCTION=${current_vip}
}

function wait_for_conductor {
   echo "$(date "+%D %H:%M:%S") INFO: Try connecting to conductor to check its alive:"
   echo "$(date "+%D %H:%M:%S") INFO: Url is: http://${CONDUCTOR_IP}:8084/IDGeneratorV2/api/v2/IDGenerator/lastGeneratedId"
   return_code=$(curl -s -o /dev/null -I -w "%{http_code}"  http://${CONDUCTOR_IP}:8084/IDGeneratorV2/api/v2/IDGenerator/lastGeneratedId)
   while [ ${return_code} -ne 200 ];do
	echo -n "."
	sleep 20
	return_code=$(curl -s -o /dev/null -I -w "%{http_code}"  http://${CONDUCTOR_IP}:8084/IDGeneratorV2/api/v2/IDGenerator/lastGeneratedId)
   done
}

function wait_for_ace_orch {
        local ingess_ip=$1
        echo "$(date "+%D %H:%M:%S") INFO: Try connecting to ace_orchestrator to check its alive:"
        echo "$(date "+%D %H:%M:%S") INFO: Url: http://${ingess_ip}/orchestrator/isReady"
        return_code=$(curl -s -o /dev/null -I -w "%{http_code}" http://${ingess_ip}/orchestrator/isReady -H 'Authorization: Bearer ZnNvY2lldHk=')
        while [ ${return_code} -ne 200 ];do
                echo -n "."
                sleep 20
                return_code=$(curl -s -o /dev/null -I -w "%{http_code}" http://${ingess_ip}/orchestrator/isReady -H 'Authorization: Bearer ZnNvY2lldHk=')
        done
        echo ""
        echo "$(date "+%D %H:%M:%S") INFO: ace_orchestrator is up"
}

function add_site {
        echo "$(date "+%D %H:%M:%S") INFO: ******* Adding site ${RADCOM_SITE} to topology"
        site_json='''
         {
            "name": "SITE_PLACEHOLDER",
            "role": "ROLE_PLACEHOLDER",
            "description": "SITE_PLACEHOLDER",
            "siteType": "SITE_TYPE_PLACEHOLDER",
            "infrastructureType": "Cloud",  
            "k8sInfrastructure": "RADCOM"
        }
        '''
        
        if [ "X${RADCOM_SITE_TYPE}" == 'Xnational' ];then
            role='national'
        else
            role='regional'
        fi
        create_site_template=$(echo ${site_json}| sed "s/SITE_PLACEHOLDER/${RADCOM_SITE}/g" | sed "s/ROLE_PLACEHOLDER/${role}/g"| sed "s/SITE_TYPE_PLACEHOLDER/${RADCOM_SITE_TYPE}/g")
	if (eval curl -s -X POST http://${CONDUCTOR_IP}:8084/MaveriQConductor/api/AddSite -H \"Content-Type: application/json\" -d \'${create_site_template}\');then
           echo ""
           echo "$(date "+%D %H:%M:%S") INFO: Site ${RADCOM_SITE} was added to topology"     
        else
           echo ""
           echo "$(date "+%D %H:%M:%S") ERROR: Site ${RADCOM_SITE} was NOT added to topology"
        fi       
}

function add_blueprint {     
        echo "$(date "+%D %H:%M:%S") INFO:***** Adding blurprint with version ${RADCOM_VERSION}"    
        json_data="{\"Version\": \"${RADCOM_VERSION}\", \"Repository\": \"${RADCOM_SRP_IP}\"}"
        eval curl -f -X POST http://${CONDUCTOR_IP}:8084/orchestrator/v1/addVersionBlueprints -H 'Authorization: Bearer ZnNvY2lldHk=' -H \"Content-Type: application/json\" -d \'${json_data}\'
}

export CONDUCTOR_IP=$(get_ip_mode_str $RADCOM_CONDUCTOR_IP)
wait_for_conductor
echo ""