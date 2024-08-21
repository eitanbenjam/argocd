import argparse,os
import yaml
import sys
import ruamel.yaml



def read_text_file(file_path):
    f = open(file_path, "r")
    data = f.readlines()
    return data 



def read_yaml_file2(file_path):
    yaml = ruamel.yaml.YAML()

    with open(file_path) as ifp:
        data = yaml.load_safe(ifp)
    return data

def write_to_yaml_file(file_path, parsed_yaml):
    anchor_keys = [ k for k in parsed_yaml.keys() if k.endswith("_PLACEHOLDER")]
    anchor_data = {}
    for anchor in anchor_keys: 
       anchor_data[anchor] = parsed_yaml[anchor] 
    filestr=yaml.dump(parsed_yaml)
    file_lines=filestr.splitlines()
    output=[]
    for line in file_lines:
        for anchor_key, anchor_value in anchor_data.items():
            if line.startswith(anchor):
                output.append(f"{anchor_key}: &{anchor_key} {anchor_value}")
                break
            elif anchor_value in line:
                output.append(line.replace(anchor_value, f"*{anchor_key}"))
                break
            else:
                output.append(line)
        
    #import pdb;pdb.set_trace()
    f = open(file_path, "w")
    f.write("\n".join(output))
    f.close()
    





def read_yaml_file(file_path):
    with open(file_path, "r") as stream:
        try:
            return yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print("Cant load yaml file to %s" % file_path)
            print(exc)
            return None

def write_to_yaml_file_regular(file_path, parsed_yaml):
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
    argo_values_general_data = read_yaml_file(os.path.join(script_args.git_folder, "applications", "general", "values.yaml"))
    argo_git = argo_values_general_data['GIT']
    argo_branch = argo_values_general_data['GIT_BRANCH']

    for bp in blueprint_json:
        bp_type = bp['blueprintType']
        bp_version = ".".join([bp['version'].split(".")[0],bp['version'].split(".")[1],bp['version'].split(".")[-1]])
        bp_name = bp['blueprintName']
        git_folder_name = os.path.join(script_args.git_folder, "applications", bp_type)
        bp_argo_file = os.path.join(script_args.git_folder, "applications", bp_type, "argo_manifast.yaml")
        try:
            bp_argo_data = read_yaml_file(bp_argo_file)
        except FileNotFoundError:
            print (f"No manifast for {bp_type}")
            break
        bp_argo_data['spec']['sources'][0]['repoURL'] = argo_git
        bp_argo_data['spec']['sources'][0]['targetRevision'] = argo_branch
        #import pdb;pdb.set_trace()
        #****  Setting values.yaml placeholder
        #try:
        #    argo_values_data = read_yaml_file(os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml"))
            
        #    placeholder_keys = [ x.split('_PLACEHOLDER')[0] for x in argo_values_data.keys() if x.endswith("_PLACEHOLDER") ]
        #    for placeholder in placeholder_keys:
        #        try:
        #            general_placeholder_value = argo_values_general_data[placeholder]
        #            argo_values_data[f"{placeholder}_PLACEHOLDER"] = argo_values_general_data[placeholder]
        #        except KeyError:
        #            print (f"ERROR: {placeholder} not exist in general values.yaml file")
        #            sys.exit(1)
                
        #    write_to_yaml_file(os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml"), argo_values_data)
        #except FileNotFoundError:
        #    print ("no values.yaml file")
        #****
        
        
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
                        

                        
                        
                        #argo_values_data = read_yaml_file(os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml"))
                        #argo_values_data['chartsetConfigurationName'] = f"{chart_set_values_file_name}.yaml"
                        #write_to_yaml_file(os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml"), argo_values_data)
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
        print (f"Saving argo_manifast to {bp_argo_file}")
        write_to_yaml_file_regular(bp_argo_file, bp_argo_data)

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

