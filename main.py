import os 

dir_path = os.path.dirname(os.path.realpath(__file__))

config_file_path = os.path.join(dir_path, 'config.txt')

# Read the configuration file to get the file path
with open(config_file_path, 'r') as config_file:
    config_lines = config_file.readlines()

# Extract the file path from the configuration file
file_path = None
for line in config_lines:
    if line.startswith('file_path='):
        file_path = line.split('=')[1].strip()
        break

if file_path:
    # Read the file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Modify the specific line
    for i, line in enumerate(lines):
        if 'setting.fullscreen_min_on_focus_loss' in line:
            lines[i] = '\t"setting.fullscreen_min_on_focus_loss"\t\t"0"\n'
            break

    # Write the changes back to the file
    with open(file_path, 'w') as file:
        file.writelines(lines)

    print("The value of 'setting.fullscreen_min_on_focus_loss' has been updated to '0'.")
else:
    print("File path not found in the configuration file.")