'''
Config generator script for CSV
'''

import jinja2
import os

template_dir = "conf.d"
template_file = f"{template_dir}/switch.j2"

csv_parameter_file = f"{template_dir}/parameters.csv"
config_parameters = []
output_dir = "_output"

# 1. Read parameters from CSV file
print("Read CSV parameter file...")
with open(csv_parameter_file) as f:
    csv_data = f.read()

# 2. Convert the CSV data to dict
print("Convert CSV file to dictionary...")
csv_lines = csv_data.splitlines()
headers = csv_lines[0].split(";")
for i in range(1, len(csv_lines)):
    values = csv_lines[i].split(";")
    parameter_dict = dict()
    for h in range(0, len(headers)):
        parameter_dict[headers[h]] = values[h]
    config_parameters.append(parameter_dict)

# 3. Create Jinja2 environment and load template file
print("Create Jinja2 environment...")
env = jinja2.Environment(loader=jinja2.FileSystemLoader(searchpath='.'))
template = env.get_template(template_file)

# create output dir if needed
if not os.path.exists(output_dir):
    os.mkdir(output_dir)

# 4. Use template to build the config
print("Build configs from template and parameters...")
for parameter in config_parameters:
    result = template.render(parameter)
    fname = parameter['hostname'] + ".config"
    with open(os.path.join(output_dir, fname), "w") as f:
        f.write(result)
    print(f"\tConfiguration {fname} created.")

print("DONE")
