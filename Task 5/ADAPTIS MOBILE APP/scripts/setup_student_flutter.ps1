param(
  [string]$RunnerName = "student_mobile_runner"
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root "student_mobile"
$runner = Join-Path $root $RunnerName

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw "Flutter was not found. Install Flutter first, then run this script again."
}

if (-not (Test-Path $runner)) {
  flutter create --project-name adaptis_student_mobile --org cm.adaptis --platforms android $runner
}

Copy-Item -LiteralPath (Join-Path $source "pubspec.yaml") -Destination (Join-Path $runner "pubspec.yaml") -Force
Copy-Item -LiteralPath (Join-Path $source "analysis_options.yaml") -Destination (Join-Path $runner "analysis_options.yaml") -Force
New-Item -ItemType Directory -Force -Path (Join-Path $runner "lib") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $runner "assets") | Out-Null
Copy-Item -Path (Join-Path $source "lib\*") -Destination (Join-Path $runner "lib") -Recurse -Force
Copy-Item -Path (Join-Path $source "assets\*") -Destination (Join-Path $runner "assets") -Recurse -Force

Push-Location $runner
flutter pub get
Pop-Location

Write-Host "Ready. Run the app with:"
Write-Host "cd $runner"
Write-Host "flutter run"
