$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
$distDir = Join-Path $repoRoot "dist"
$outputFile = Join-Path $distDir "love2d-game.love"

$includePaths = @(
    "assets",
    "Ennemis",
    "libs",
    "maps",
    "Signs",
    "background.lua",
    "camera.lua",
    "conf.lua",
    "controls.lua",
    "debugging.lua",
    "game.lua",
    "main.lua",
    "map.lua",
    "menu.lua",
    "player.lua",
    "runner.lua"
)

if (Test-Path $distDir) {
    Remove-Item -LiteralPath $distDir -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $distDir | Out-Null

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zip = [System.IO.Compression.ZipFile]::Open($outputFile, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($relativePath in $includePaths) {
        $sourcePath = Join-Path $repoRoot $relativePath
        if (-not (Test-Path $sourcePath)) {
            throw "Missing build input: $relativePath"
        }

        if (Test-Path $sourcePath -PathType Container) {
            Get-ChildItem -LiteralPath $sourcePath -Recurse -File | ForEach-Object {
                $entryName = $_.FullName.Substring($repoRoot.Length).TrimStart("\", "/") -replace "\\", "/"
                [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                    $zip,
                    $_.FullName,
                    $entryName,
                    [System.IO.Compression.CompressionLevel]::Optimal
                ) | Out-Null
            }
        } else {
            $entryName = $relativePath -replace "\\", "/"
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $zip,
                $sourcePath,
                $entryName,
                [System.IO.Compression.CompressionLevel]::Optimal
            ) | Out-Null
        }
    }
} finally {
    $zip.Dispose()
}

$zipEntries = [System.IO.Compression.ZipFile]::OpenRead($outputFile)
try {
    if (-not ($zipEntries.Entries | Where-Object { $_.FullName -eq "main.lua" })) {
        throw "Invalid .love package: main.lua is not at the archive root."
    }
} finally {
    $zipEntries.Dispose()
}

Write-Host "Built Android-ready LOVE package:"
Write-Host $outputFile
