$ErrorActionPreference = "Stop"
$appName = -join [char[]](0x9759, 0x9ED8, 0x5F85, 0x529E)
$buildName = "QuietTodoWidget"

$python = "D:\Environments\Python314\python.exe"
if (-not (Test-Path -LiteralPath $python)) {
    $python = "python"
}

& $python -m pip install -r "$PSScriptRoot\requirements.txt"
& $python -m PyInstaller `
    --noconfirm `
    --clean `
    --windowed `
    --onefile `
    --distpath "$PSScriptRoot\dist" `
    --workpath "$PSScriptRoot\build" `
    --specpath "$PSScriptRoot\build" `
    --name $buildName `
    "$PSScriptRoot\todo_widget.py"

$builtExe = Join-Path "$PSScriptRoot\dist" "$buildName.exe"
$finalExe = Join-Path "$PSScriptRoot\dist" "$appName.exe"
Move-Item -LiteralPath $builtExe -Destination $finalExe -Force

Write-Host "Built: $PSScriptRoot\dist\$appName.exe"
