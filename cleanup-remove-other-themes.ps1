param(
	[switch]$Execute
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$htmlDir = Join-Path $scriptDir 'html'
$keep = 'vertical-menu-template-no-customizer'

if (-not (Test-Path $htmlDir)) {
	Write-Host "No html directory found at $htmlDir"
	exit 1
}

$folders = Get-ChildItem -Path $htmlDir -Directory | Where-Object { $_.Name -ne $keep }

if ($folders.Count -eq 0) {
	Write-Host "No other theme folders to remove."
	exit 0
}

Write-Host "Found the following folders to remove:"
$folders | ForEach-Object { Write-Host "- $($_.FullName)" }

if (-not $Execute) {
	Write-Host ""
	Write-Host "Dry run. To actually delete the folders, re-run this script with the -Execute switch:"
	Write-Host "  .\cleanup-remove-other-themes.ps1 -Execute"
	exit 0
}

foreach ($f in $folders) {
	Write-Host "Removing $($f.FullName)..."
	Remove-Item -LiteralPath $f.FullName -Recurse -Force
}

Write-Host "Cleanup complete."
