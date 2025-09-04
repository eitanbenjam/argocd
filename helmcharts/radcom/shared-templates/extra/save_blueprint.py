import argparse, sys, logging, json
sys.path.append('.')
from common.utils.common_functions import exit_script, read_yaml_file
from common.utils.common_functions import send_url

def get_vpc_from_yaml(eks_yaml_subnets):
    print ("got:%s" % eks_yaml_subnets)
    if type(eks_yaml_subnets) == dict:
        for k in eks_yaml_subnets:
            return get_vpc_from_yaml(eks_yaml_subnets[k])
    elif type(eks_yaml_subnets) == str:
            return eks_yaml_subnets
    else:
        return None


#def save_blueprint_deployment(blueprint, site_info, bp_type, blueprint_json_data, site_name,
#                              blueprint_value_yaml_filename, primary_kbr_ip, cloud_object):
def save_blueprint_deployment(script_args):
    blueprint = script_args.cs_name.replace("cs-","bp-")
    logging.info(f"Saving blueprint {blueprint} deployment")
    deployment_name = script_args.deployment_name

    deployment_attributes_map = read_yaml_file(script_args.value_file)
    try:
        del deployment_attributes_map['radcom-chart-library-chart']
    except (TypeError, KeyError):
        pass

    try:
        del deployment_attributes_map['global']
    except TypeError:
        pass

    data = {
        "deploymentName": deployment_name,
        "blueprintType": blueprint,
        "blueprintVersion": script_args.deployment_version,
        "targetVersion": "",
        "previousVersion": "",
        "siteName": script_args.site_name,
        "blueprintConfigurationName": "",
        "blueprintConfigurationRevision": "",
        "targetBlueprintConfiguration": "",
        "targetBlueprintConfigurationRevision": "",
        "deploymentAttributes": deployment_attributes_map
    }
    headers = {"Content-Type": "application/json"}
    http_response = send_url("http://{0}/managerAce/saveBlueprintDeployment", script_args.ingress_address, "POST", [200, 403], data=json.dumps(data), headers=headers)
    logging.info(http_response['text'])
    if http_response['status_code'] == 200:
        exit_script(f"Blueprint {blueprint} Deployment Saved", 0)
    elif http_response['status_code'] == 403:
        if "already deployed on the site" in http_response['text'] or "already exists" in http_response['text']:
            logging.warning(f"{http_response['text']}")
        else:
            exit_script(f"Blueprint Deployment {blueprint} failed to save:{http_response['text']}", 1)
    else:
        exit_script(f"Blueprint Deployment {blueprint} failed to save", 1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ingress_address", '--ing_addr', help="NGINX ingress ip", required=True)
    parser.add_argument('--value_file', dest='value_file', help='values.yaml file location',required=True)
    parser.add_argument('--site_name', dest="site_name", metavar='SITES', action='store', 
                        type=str, help='sites to upgrade delemeter by ,', required=True)
    parser.add_argument('--deployment_name', dest='deployment_name', help='helm deployment name',required=True)
    parser.add_argument('--deployment_version', dest='deployment_version', help='helm deployment version',required=True)
    parser.add_argument('--cs_name', dest='cs_name', help='Chartset name',required=True)
   
    args = parser.parse_args()
    save_blueprint_deployment(args)
