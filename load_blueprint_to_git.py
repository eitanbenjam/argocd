import argparse
import yaml, os
import shutil


def read_yaml_file(file_path):
    with open(file_path, "r") as stream:
        try:
            return yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print("Cant load yaml file to %s" % file_path)
            print(exc)
            return None

def write_to_yaml_file(file_path, parsed_yaml):
    """
    This function creates new yaml file
    :param file_path: The path to the yaml file
    :param parsed_yaml: the parsed yaml
    """

    with open(file_path, 'w') as yamlFile:
        try:
            noalias_dumper = yaml.dumper.SafeDumper
            noalias_dumper.ignore_aliases = lambda self, data: True
            yamlFile.write(yaml.dump(parsed_yaml, default_flow_style=False, Dumper=noalias_dumper))
        except yaml.YAMLError as exc:
            print(exc)


def main(script_args):

    blueprint_json = read_yaml_file(script_args.blueprints_json)
    for bp in blueprint_json:
        bp_type = bp['blueprintType']
        bp_version = ".".join([bp['version'].split(".")[0],bp['version'].split(".")[1],bp['version'].split(".")[-1]])

        bp_name = bp['blueprintName']
        git_folder_name = os.path.join(script_args.git_folder, "applications", bp_type)
        #import pdb;pdb.set_trace()
        if os.path.exists(git_folder_name):
            print (f"**** Start working on blueprint {bp_name}, bp_type: {bp_type} ***")
            bp_chart_file = os.path.join(script_args.git_folder, "applications", bp_type, "Chart.yaml")
            try:
                bp_chart_data = read_yaml_file(bp_chart_file)
                for chartset in bp['chartsets']:
                    print (f"INFP:******{bp_name}, {bp_type}, {chartset}")
                    cs_version = chartset['chartsetVersion']
                    cs_name = chartset['chartsetName']
                    chart_set_values_file_name = chartset['chartsetConfigurationName']
                    if chart_set_values_file_name != "":
                        bp_argo_file = os.path.join(script_args.git_folder, "applications", bp_type, "argo_manifast.yaml")
                        bp_argo_data = read_yaml_file(bp_argo_file)
                        
                        print (f"will copy file {chart_set_values_file_name} to {git_folder_name}")
                        git_blueprint_folder = os.path.join(git_folder_name, "blueprint_value")
                        
                        if not os.path.exists(git_blueprint_folder):
                            os.mkdir(git_blueprint_folder)
                        chart_set_values_file=os.path.join(script_args.blueprints_folder, bp_type,"configuration",f"{chart_set_values_file_name}.yaml")
                        bp_data = read_yaml_file(chart_set_values_file)
                        try:
                            global_bp_data = bp_data['global']
                            del bp_data['global']
                        except KeyError:
                            global_bp_data = None
                        bp_data = { f'{cs_name}': bp_data }
                        if global_bp_data:
                            bp_data['global'] = global_bp_data

                        
                        #import pdb;pdb.set_trace()
                        write_to_yaml_file(os.path.join(script_args.git_folder,git_blueprint_folder, f"{chart_set_values_file_name}.yaml"), bp_data)
                        #
                        #shutil.copy(chart_set_values_file, git_blueprint_folder)
                        bp_argo_data['spec']['sources'][0]['helm']['valueFiles'] = [f'blueprint_value/{chart_set_values_file_name}.yaml','../general/values.yaml' ,'values.yaml']
                        

                        print (f"Saving argo_manifast to {bp_argo_file}")
                        write_to_yaml_file(bp_argo_file, bp_argo_data)
                        
                        argo_values_data = read_yaml_file(os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml"))
                        argo_values_data['chartsetConfigurationName'] = f"{chart_set_values_file_name}.yaml"
                        write_to_yaml_file(os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml"), argo_values_data)
                        #

                    #Version
                    
                    for cs_dep in bp_chart_data['dependencies']:
                        if cs_dep['name'] == cs_name:
                            print (f"Setting chartset {cs_name} to version:{cs_version} on blueprint:{bp_name}")
                            cs_dep['version'] = cs_version
                        
                
                print (f"Setting blueprint {bp_name} to version:{bp_version}")
                bp_chart_data['version'] = bp_version
                write_to_yaml_file(bp_chart_file, bp_chart_data)
            except FileNotFoundError:
                print (f"cant open Cahrt.yaml {bp_name}")


                
        else:
            if not os.path.exists(git_folder_name):
                os.mkdir(git_folder_name)
            print (f"blueprint {bp_type} not exist in git, skipping , {git_folder_name}")   


            #import pdb;pdb.set_trace()
    #for root, dirs, files in os.walk(script_args.blueprints_folder, topdown=False):
        #for name in files:
        #    print(os.path.join(root, name))
    #    for bp_name in dirs:
    #        git_folder_name = os.path.join(script_args.git_folder, "applications", bp_name)
    #        print ("bp %s, git %s" %(bp_name, git_folder_name))
    #        blueprint_folder_name = os.path.join(script_args.blueprints_folder,bp_name,"configuration")
    #        for bp_root, bp_dirs, bp_files in os.walk(blueprint_folder_name):
    #            for bp_name in bp_files:
    #                print (bp_name)
            
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-g", '--git_folder', help="localtion of git folder", required=True)    
    parser.add_argument("-b", '--blueprints_folder', help="localtion of blueprints folder", required=True)  
    parser.add_argument("-j", '--blueprints_json', help="localtion of blueprints.json", required=True)  
    args = parser.parse_args()
    main(args)

