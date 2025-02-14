# filepath: /E:/dev/cs2-alt-tab-fix/main.ps1

$dirPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$configFilePath = Join-Path $dirPath 'config.txt'

# Read the configuration file to get the file path
$configLines = Get-Content $configFilePath

# Extract the file path from the configuration file
$filePath = $null
foreach ($line in $configLines) {
    if ($line -match '^file_path=') {
        $filePath = $line -replace '^file_path=', ''
        $filePath = $filePath.Trim()
        break
    }
}

if ($filePath) {
    # Read the file
    $lines = Get-Content $filePath

    # Modify the specific line
    for ($i = 0; $i -lt $lines.Length; $i++) {
        if ($lines[$i] -match 'setting.fullscreen_min_on_focus_loss') {
            $lines[$i] = "`t`"setting.fullscreen_min_on_focus_loss`"`t`t`"0`""
            break
        }
    }

    # Write the changes back to the file
    Set-Content -Path $filePath -Value $lines

    Write-Output "The value of 'setting.fullscreen_min_on_focus_loss' has been updated to '0'."
} else {
    Write-Output "File path not found in the configuration file."
}