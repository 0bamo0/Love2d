$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
$resultPath = Join-Path $repoRoot "tests\results.txt"

$loveCommand = Get-Command love -ErrorAction SilentlyContinue
if ($loveCommand) {
    $loveExe = $loveCommand.Source
} elseif (Test-Path "C:\Program Files\LOVE\love.exe") {
    $loveExe = "C:\Program Files\LOVE\love.exe"
} else {
    throw "Could not find love.exe. Add LOVE to PATH or install it at C:\Program Files\LOVE\love.exe."
}

if (Test-Path $resultPath) {
    Remove-Item -LiteralPath $resultPath
}

Push-Location $repoRoot
try {
    $process = Start-Process `
        -FilePath $loveExe `
        -ArgumentList @(".", "--test") `
        -WorkingDirectory $repoRoot `
        -Wait `
        -PassThru `
        -WindowStyle Hidden
    $exitCode = $process.ExitCode
} finally {
    Pop-Location
}

if (Test-Path $resultPath) {
    Get-Content -LiteralPath $resultPath
} else {
    Write-Error "The test runner did not produce tests\results.txt."
    $exitCode = 1
}

exit $exitCode
