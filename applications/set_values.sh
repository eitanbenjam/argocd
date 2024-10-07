#!/bin/bash
function help_menu {
        echo "This script will patch extarnal orchestrator configMap , can path sites to run, rpm_repository and configuration_folder (source_config)."
        echo "example command:"
        echo "$0 -b <blueprint_folder> -j <blueprint_json> -g <git_folder>"
        echo "-b - blueprint folder that contains the yaml files"
        echo "-j - blueprint.json file location"
        echo "-g - git folder"
        
        exit 0

}

if [ $# -lt 2 ]; then
        help_menu
fi
while getopts b:j:g: flag
do
    case "${flag}" in
       b) blueprint_folder=${OPTARG};;
       j) blueprint_json=${OPTARG};;
       g) git_folder=${OPTARG};;
       \?) valid=0
            help_menu
            ;;
    esac
done









arr="HELM_REGISTRY SITE_EVENT_BUS_STORAGE SITE_OBJECT_STORAGE SITE_GENERAL_STORAGE SITE_HEALTH_STORAGE SITE_ELASTIC_STORAGE SITE CONDUCTOR_VIP DOCKER_REGISTRY VERSION DOCKER_REGISTRY NAMESPACE"
file_list=$(find . -type f -name "values*.yaml"|grep -v general/values.yaml)
for value_name in ${arr[@]};do
	#echo $value_name
	value=$(grep ^${value_name}: general/values.yaml |awk '{print $3}'|sed "s/&//g")
	echo Setting ${value_name} to ${value}
	for file in ${file_list[@]};do
		#echo "${value_name}_PLACEHOLDER:.* to \&${value_name}_PLACEHOLDER ${value} $file"
		sed -i "s%^${value_name}_PLACEHOLDER:.*%${value_name}_PLACEHOLDER: \&${value_name}_PLACEHOLDER ${value}%" ${file}
	done	
done


file_list=$(find . -type f -name "Chart.yaml")
for value_name in ${arr[@]};do
        #echo $value_name
        value=$(grep ^${value_name}: general/values.yaml |awk '{print $3}'|sed "s/&//g")
        echo Setting ${value_name} to ${value}
        for file in ${file_list[@]};do
                #echo "${value_name}_PLACEHOLDER:.* to \&${value_name}_PLACEHOLDER ${value} $file"
                sed -i "s%^${value_name}_PLACEHOLDER:.*%${value_name}_PLACEHOLDER: \&${value_name}_PLACEHOLDER ${value}%" ${file}
        done
done



#cat bp-oam-agent-region/Chart.yaml | yq  '.dependencies[] | select(.name == "cs-oam-agent").version = "eitan"'


# cat bp-oam-agent-region/Chart.yaml | yq  '.version = "172.16.87.98"'



python3 ${git_folder}/load_blueprint_to_git.py -g ${git_folder} -b ${blueprint_folder} -j ${blueprint_json}
