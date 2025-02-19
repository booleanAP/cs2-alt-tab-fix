import os 
import glob

directories = [
    r"C:\Program Files (x86)\Steam\userdata\*",
    r"D:\Program Files (x86)\Steam\userdata\*"
]

for directory in directories:
    for subfolder in glob.glob(directory):
        cs2_video_path = os.path.join(subfolder, "730", "local", "cfg", "cs2_video.txt")
        if os.path.exists(cs2_video_path):
            with open(cs2_video_path, 'r') as file:
                lines = file.readlines()

            for i, line in enumerate(lines):
                if 'setting.fullscreen_min_on_focus_loss' in line:
                    lines[i] = '\t"setting.fullscreen_min_on_focus_loss"\t\t"0"\n'
                    break

            with open(cs2_video_path, 'w') as file:
                file.writelines(lines)

            print(f"The value of 'setting.fullscreen_min_on_focus_loss' has been updated to '0' in {cs2_video_path}.")
            
# Wait for user input before closing
input("Press Enter to exit...")
