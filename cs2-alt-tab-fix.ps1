$directories = @(
    "C:\Program Files (x86)\Steam\userdata\*",
    "D:\Program Files (x86)\Steam\userdata\*"
)

foreach ($directory in $directories) {
    if (Test-Path -Path $directory) {
        $subfolders = Get-ChildItem -Path $directory -Directory
        foreach ($subfolder in $subfolders) {
            $cs2_video_path = Join-Path -Path $subfolder.FullName -ChildPath "730\local\cfg\cs2_video.txt"
            if (Test-Path -Path $cs2_video_path) {
                $lines = Get-Content -Path $cs2_video_path

                for ($i = 0; $i -lt $lines.Length; $i++) {
                    if ($lines[$i] -match 'setting.fullscreen_min_on_focus_loss') {
                        $lines[$i] = $lines[$i] -replace '"1"', '"0"'
                        break
                    }
                }

                Set-Content -Path $cs2_video_path -Value $lines

                Write-Output "The value of 'setting.fullscreen_min_on_focus_loss' has been updated to '0' in $cs2_video_path."
            }
        }
    }
}
# Prompt to press enter to exit
Read-Host -Prompt "Press enter to exit"