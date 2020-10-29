'''
Config generator for JSON
'''

import jinja2
import json
import os

template_dir = "conf.d"
template_file = f"{template_dir}/switch_with_vlans.j2"

json_parameter_file = f"{template_dir}/parameters.json"
output_dir = "_output"

print("Read JSON parameter file...")
config_parameters = json.load(open(json_parameter_file))

print("Create Jinja2 environment...")
env = jinja2.Environment(loader=jinja2.FileSystemLoader(searchpath='.'),
                         trim_blocks=True,
                         lstrip_blocks=True)
template = env.get_template(template_file)

if not os.path.exists(output_dir):
    os.mkdir(output_dir)

print("Build configs from template and parameters...")
for parameter in config_parameters:
    result = template.render(parameter)
    fname = parameter['hostname'] + "_with_vlans.config"
    with open(os.path.join(output_dir, fname), "w") as f:
        f.write(result)
    print(f"\tConfiguration {fname} created...")

print("DONE")
