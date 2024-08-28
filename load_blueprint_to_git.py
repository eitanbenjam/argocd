import argparse,os, traceback
import yaml
import sys
#import ruamel.yaml



def read_text_file(file_path):
    f = open(file_path, "r")
    data = f.readlines()
    return data 



def write_to_yaml_file(file_path, parsed_yaml, argo_values_general_data, debug=False):
    def update_line_with_value(line, used_anchors_values):
        for value in used_anchors_values:
            #print (line)
            #import pdb;pdb.set_trace()
            #if line.startswith("      siteName"):
            #    import pdb;pdb.set_trace()
            line = line.replace(f" {value['org_anchor_value']}", f" *{value['anchor_name']}_PLACEHOLDER")
        return line
    anchor_keys = [ k for k in parsed_yaml.keys() if k.endswith("_PLACEHOLDER")]
    if len(anchor_keys) > 0:
        
        anchor_data = {}
        used_anchors_values = []
        for anchor in anchor_keys: 
            anchor_data[anchor] = parsed_yaml[anchor] 
            filestr=yaml.dump(parsed_yaml)
            file_lines=filestr.splitlines()
            output=[]
            for line in file_lines:
                anchor_key = line.split(":")[0]
                if anchor_key in anchor_keys:
                    anchor_key_general_name = anchor_key.split("_PLACEHOLDER")[0]
                    output.append(f"{anchor_key}: &{anchor_key} {argo_values_general_data[anchor_key_general_name]}")
                    used_anchors_values.append({"anchor_name": anchor_key_general_name,"org_anchor_value": line.split()[-1], "anchor_value": argo_values_general_data[anchor_key_general_name]})
                else:
                    output.append(update_line_with_value(line, used_anchors_values))
                #print (f"line is {line}, output is:")
                #print (f"{output}")            



                #for anchor_key, anchor_value in anchor_data.items():
                #    anchor_key_general_name = anchor_key.split("_PLACEHOLDER")[0]
                #    if debug:
                #        import pdb;pdb.set_trace()
                #    if line.startswith(f"{anchor}"):
                #        output.append(f"{anchor_key}: &{anchor_key} {argo_values_general_data[anchor_key_general_name]}")
                #        break
                #    elif anchor_value in line:
                #        output.append(line.replace(anchor_value, f"*{anchor_key}"))
                #        break
                #    else:
                #        output.append(line)
                
        print(f"wring file {file_path}")
        if debug:
            import pdb;pdb.set_trace()
        f = open(file_path, "w")
        file_output = "\n".join(output)
        #for value in used_anchors_values:
        #    file_output.replace(f" {value['anchor_value']} ", f" {value['anchor_name']} ")

        f.write("\n".join(output))
        f.close()
    else:
        write_to_yaml_file_regular(file_path, parsed_yaml)
    





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

    git_msg = []
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
        bp_helm_file = os.path.join(script_args.git_folder, "applications", bp_type, "values.yaml")
        if os.path.exists(bp_helm_file):
            bp_helm_file_data = read_yaml_file(bp_helm_file)
            write_to_yaml_file(bp_helm_file, bp_helm_file_data, argo_values_general_data, False)
        
        print (f"**** Start working on blueprint {bp_name}, bp_type: {bp_type} ***")
        
        
        if os.path.exists(git_folder_name) and os.path.exists(bp_argo_file):
            bp_argo_data = read_yaml_file(bp_argo_file)
            try:
                bp_argo_data['spec']['sources'][0]['repoURL'] = argo_git
                bp_argo_data['spec']['sources'][0]['targetRevision'] = argo_branch
            except:
                import pdb;pdb.set_trace()
            bp_chart_file = os.path.join(script_args.git_folder, "applications", bp_type, "Chart.yaml")
            try:
                bp_chart_data = read_yaml_file(bp_chart_file)
                for chartset in bp['chartsets']:
                    print (f"INFO:******{bp_name}, {bp_type}, {chartset}")
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
                        if bp_data:
                            try:
                                global_bp_data = bp_data['global']
                                del bp_data['global']
                            except KeyError:
                                global_bp_data = None
                            except TypeError:
                                import pdb;pdb.set_trace()
                            bp_data = { f'{cs_name}': bp_data }
                            if global_bp_data:
                                bp_data['global'] = global_bp_data

                            

                            destination_file_name = os.path.join(script_args.git_folder,git_blueprint_folder, f"{chart_set_values_file_name}.yaml")
                            write_to_yaml_file(destination_file_name, bp_data, argo_values_general_data)
                            bp_argo_data['spec']['sources'][0]['helm']['valueFiles'] = [f'blueprint_value/{chart_set_values_file_name}.yaml','../general/values.yaml' ,'values.yaml']
                            git_msg.append(f"git add {destination_file_name}")
                    #Version
                    
                    for cs_dep in bp_chart_data['dependencies']:
                        if cs_dep['name'] == cs_name:
                            print (f"Setting chartset {cs_name} to version:{cs_version} on blueprint:{bp_name}")
                            cs_dep['version'] = cs_version
                        
                
                #print (f"Setting blueprint {bp_name} to version:{bp_version}")
                bp_chart_data['version'] = bp_version
                write_to_yaml_file(bp_chart_file, bp_chart_data, argo_values_general_data)
            except FileNotFoundError:

                print (f"cant open Cahrt.yaml {bp_name}")


                
        else:
            if not os.path.exists(git_folder_name):
                os.mkdir(git_folder_name)
            print (f"blueprint {bp_type} not exist in git, skipping , {git_folder_name}")   
        print (f"Saving argo_manifast to {bp_argo_file}")
        write_to_yaml_file_regular(bp_argo_file, bp_argo_data)
    print ("GIT CMDS:")
    print ("\n".join(git_msg))
         
            
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-g", '--git_folder', help="localtion of git folder", required=True)    
    parser.add_argument("-b", '--blueprints_folder', help="localtion of blueprints folder", required=True)  
    parser.add_argument("-j", '--blueprints_json', help="localtion of blueprints.json", required=True)  
    args = parser.parse_args()
    main(args)

