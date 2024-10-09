import argparse
import os
import yaml
import sys

def read_text_file(file_path):
    with open(file_path, "r") as f:
        data = f.readlines()
    return data

def write_to_yaml_file(file_path, parsed_yaml, argo_values_general_data, debug=False):
    def update_line_with_value(line, used_anchors_values):
        for value in used_anchors_values:
            line = line.replace(f" {value['org_anchor_value']}", f" *{value['anchor_name']}_PLACEHOLDER")
        return line

    anchor_keys = [k for k in parsed_yaml.keys() if k.endswith("_PLACEHOLDER")]
    if anchor_keys:
        anchor_data = {}
        used_anchors_values = []
        for anchor in anchor_keys:
            anchor_data[anchor] = parsed_yaml[anchor]
            filestr = yaml.dump(parsed_yaml)
            file_lines = filestr.splitlines()
            output = []
            for line in file_lines:
                anchor_key = line.split(":")[0]
                if anchor_key in anchor_keys:
                    anchor_key_general_name = anchor_key.split("_PLACEHOLDER")[0]
                    output.append(f"{anchor_key}: &{anchor_key} {argo_values_general_data[anchor_key_general_name]}")
                    used_anchors_values.append({
                        "anchor_name": anchor_key_general_name,
                        "org_anchor_value": line.split()[-1],
                        "anchor_value": argo_values_general_data[anchor_key_general_name]
                    })
                else:
                    output.append(update_line_with_value(line, used_anchors_values))
        print(f"Writing file {file_path}")
        if debug:
            import pdb; pdb.set_trace()
        with open(file_path, "w") as f:
            file_output = "\n".join(output)
            f.write(file_output)
    else:
        write_to_yaml_file_regular(file_path, parsed_yaml)

def read_yaml_file(file_path):
    with open(file_path, "r") as stream:
        try:
            return yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(f"Cannot load YAML file: {file_path}")
            print(exc)
            return None

def write_to_yaml_file_regular(file_path, parsed_yaml):
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
    argo_values_general_data = read_yaml_file(os.path.join(script_args.git_folder, "helmcharts", "general", "values.yaml"))
    argo_git = argo_values_general_data['GIT']
    argo_branch = argo_values_general_data['GIT_BRANCH']

    for bp in blueprint_json:
        bp_type = bp['blueprintType']
        bp_version = ".".join([bp['version'].split(".")[0], bp['version'].split(".")[1], bp['version'].split(".")[-1]])
        bp_name = bp['blueprintName']
        git_folder_name = os.path.join(script_args.git_folder, "helmcharts", bp_type)
        bp_helm_file = os.path.join(script_args.git_folder, "helmcharts", bp_type, "values.yaml")

        if os.path.exists(bp_helm_file):
            bp_helm_file_data = read_yaml_file(bp_helm_file)
            write_to_yaml_file(bp_helm_file, bp_helm_file_data, argo_values_general_data, False)

        print(f"**** Start working on blueprint {bp_name}, bp_type: {bp_type} ***")

        if os.path.exists(git_folder_name):
            bp_chart_file = os.path.join(script_args.git_folder, "helmcharts", bp_type, "Chart.yaml")
            try:
                bp_chart_data = read_yaml_file(bp_chart_file)
                for chartset in bp['chartsets']:
                    print(f"INFO: Processing chartset {chartset['chartsetName']} for blueprint {bp_name}, type {bp_type}")
                    cs_version = chartset['chartsetVersion']
                    cs_name = chartset['chartsetName']
                    chart_set_values_file_name = chartset['chartsetConfigurationName']
                    if chart_set_values_file_name:
                        print(f"Copying file {chart_set_values_file_name} to {git_folder_name}")
                        git_blueprint_folder = os.path.join(git_folder_name, "blueprint_value")
                        if not os.path.exists(git_blueprint_folder):
                            os.mkdir(git_blueprint_folder)
                        chart_set_values_file = os.path.join(script_args.blueprints_folder, bp_type, "configuration", f"{chart_set_values_file_name}.yaml")
                        bp_data = read_yaml_file(chart_set_values_file)
                        if bp_data:
                            try:
                                global_bp_data = bp_data['global']
                                del bp_data['global']
                            except KeyError:
                                global_bp_data = None
                            bp_data = {cs_name: bp_data}
                            if global_bp_data:
                                bp_data['global'] = global_bp_data

                            destination_file_name = os.path.join(script_args.git_folder, git_blueprint_folder, "values.yaml")
                            write_to_yaml_file(destination_file_name, bp_data, argo_values_general_data)
                            git_msg.append(f"git add {destination_file_name}")

                    for cs_dep in bp_chart_data['dependencies']:
                        if cs_dep['name'] == cs_name:
                            print(f"Setting chartset {cs_name} to version {cs_version} for blueprint {bp_name}")
                            cs_dep['version'] = cs_version

                bp_chart_data['version'] = bp_version
                write_to_yaml_file(bp_chart_file, bp_chart_data, argo_values_general_data)
            except FileNotFoundError:
                print(f"Cannot open Chart.yaml for {bp_name}")
        else:
            if not os.path.exists(git_folder_name):
                os.mkdir(git_folder_name)
            print(f"Blueprint {bp_type} does not exist in git, skipping {git_folder_name}")

    print("GIT CMDS:")
    print("\n".join(git_msg))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-g", '--git_folder', help="Location of git folder", required=True)
    parser.add_argument("-b", '--blueprints_folder', help="Location of blueprints folder", required=True)
    parser.add_argument("-j", '--blueprints_json', help="Location of blueprints.json", required=True)
    args = parser.parse_args()
    main(args)
