import sys
import ruamel.yaml

yaml_str = """\
dev:
    value1: &dev-value1 "value1"
    value2: &dev-value2 "value2"

test:
    value1: *dev-value1
    value2: *dev-value2
"""

def read_yaml_file(file_path):
    yaml = ruamel.yaml.YAML()
    with open(file_path, "r") as stream:
        try:
            return yaml.load(stream)
        except yaml.YAMLError as exc:
            print("Cant load yaml file to %s" % file_path)
            print(exc)
            return None
        
def change_all_old_ids(d, old_id, new_value):
    """ this doesn't handle anchored keys """
    if isinstance(d, dict):
        for k, v in d.items():
            if id(v) == old_id:
                d[k] = new_value
            else:
                change_all_old_ids(v, old_id, new_value)
    elif isinstance(d, list):
        for idx, elem in enumerate(d):
            if id(elem) == old_id:
                d[idx] = new_value
            else:
                change_all_old_ids(elem, old_id, new_value)

    
yaml = ruamel.yaml.YAML()
data = read_yaml_file("Chart.yaml")
#old_value = data['dev']['value1']

#data['dev']['value1'] = new_value = type(old_value)('new_value')
#new_value.yaml_set_anchor(old_value.anchor.value, always_dump=True)

#yaml.dump(data, sys.stdout)
#print('+='*10)
#change_all_old_ids(data, id(old_value), new_value)

import pdb;pdb.set_trace()

yaml.dump(data, sys.stdout)
