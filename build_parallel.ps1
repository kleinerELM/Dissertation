param(
    [string]$DocName = "Dissertation",
    [switch]$Additionals,
    [switch]$Cleanup
)

$ErrorActionPreference = "Stop"

# Define separate build directories to prevent file conflicts during parallel execution
$DirDigital = "build_digital"
$DirPrint = "build_print"
$DirAdditional = Join-Path (Get-Location) "build_additionals"

$AdditionalDocuments = @(
    @{ Name = "summary_paper_EN"; SourceDir = "summary_paper" },
    @{ Name = "summary_paper_DE"; SourceDir = "summary_paper" },
    @{ Name = "curriculum_vitae_EN"; SourceDir = "curriculum_vitae" },
    @{ Name = "curriculum_vitae_DE"; SourceDir = "curriculum_vitae" },
    @{ Name = "thesis_overview_EN"; SourceDir = "presentations" },
    @{ Name = "thesis_overview_DE"; SourceDir = "presentations" }
)

function Invoke-Cleanup {
    Write-Host "Cleaning temporary files..."
    foreach ($directory in @($DirDigital, $DirPrint, $DirAdditional)) {
        if (Test-Path $directory) {
            Remove-Item $directory -Recurse -Force -ErrorAction Stop
        }
    }
}

$WarningCount = 0
$ErrorCount = 0

if ($Cleanup) {
    Invoke-Cleanup
}

$CurrentDir = Get-Location
$DatePrefix = Get-Date -Format "yyMMdd"

# Define build blocks
$BlockDigital = {
    param($DocName, $Dir, $WorkDir)
    Set-Location $WorkDir
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
    Write-Host "Building Digital Version..."
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -xelatex "-outdir=$Dir" "-jobname=$DocName" "$DocName.tex"
    if ($LASTEXITCODE -ne 0) { throw "Digital build failed with exit code $LASTEXITCODE." }
}

$BlockPrint = {
    param($DocName, $Dir, $WorkDir)
    Set-Location $WorkDir
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
    Write-Host "Building Print Version..."
    # Command to define PRINTABLE
    $latexCmd = "xelatex %O \def\PRINTABLE{} \input{%S}"
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -xelatex "-outdir=$Dir" "-jobname=${DocName}_print" -e "`$xelatex = '$latexCmd'" "$DocName.tex"
    if ($LASTEXITCODE -ne 0) { throw "Print build failed with exit code $LASTEXITCODE." }
}

$BlockAdditional = {
    param($DocName, $SourceDir, $OutputDir, $WorkDir)
    Set-Location (Join-Path $WorkDir $SourceDir)
    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
    Write-Host "Building $DocName..."
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -xelatex "-outdir=$OutputDir" "-jobname=$DocName" "$DocName.tex"
    if ($LASTEXITCODE -ne 0) { throw "Build of $DocName failed with exit code $LASTEXITCODE." }
}

# Start parallel jobs
Write-Host "Starting parallel builds..."
$jobs = @()
if (-not $Additionals) {
    $jobs += Start-Job -ScriptBlock $BlockDigital -ArgumentList $DocName, $DirDigital, $CurrentDir
    $jobs += Start-Job -ScriptBlock $BlockPrint -ArgumentList $DocName, $DirPrint, $CurrentDir
}
foreach ($document in $AdditionalDocuments) {
    $jobs += Start-Job -ScriptBlock $BlockAdditional -ArgumentList $document.Name, $document.SourceDir, $DirAdditional, $CurrentDir
}

# Wait for jobs to complete
Wait-Job -Job $jobs | Out-Null

# Output results
foreach ($j in $jobs) {
    if ($j.State -eq "Failed") {
        Write-Error "Build job failed: $($j.ChildJobs[0].JobStateInfo.Reason.Message)" -ErrorAction Continue
        $ErrorCount++
    }
    Receive-Job -Job $j -ErrorAction Continue
}


# Move PDFs to root
if (-not $Additionals) {
    $pdfsToMove = @(
        @{ Source = "$DirDigital\$DocName.pdf"; Target = ".\${DatePrefix}_${DocName}.pdf" },
        @{ Source = "$DirPrint\${DocName}_print.pdf"; Target = ".\${DatePrefix}_${DocName}_print.pdf" }
    )
} else {
    $pdfsToMove = @()
}

foreach ($document in $AdditionalDocuments) {
    $pdfsToMove += @{ Source = (Join-Path $DirAdditional "$($document.Name).pdf"); Target = ".\${DatePrefix}_$($document.Name).pdf" }
}

foreach ($pdf in $pdfsToMove) {
    if (-not (Test-Path $pdf.Source)) {
        Write-Warning "PDF not found, cannot move: $($pdf.Source)"
        $WarningCount++
        continue
    }
    Move-Item $pdf.Source $pdf.Target -Force
}

if ($Cleanup) {
    Invoke-Cleanup
}

Remove-Job -Job $jobs

if ($ErrorCount -gt 0) {
    Write-Host "Build finished with errors ($ErrorCount error(s), $WarningCount warning(s))." -ForegroundColor Red
    exit 1
}
if ($WarningCount -gt 0) {
    Write-Host "Build finished with warnings ($WarningCount warning(s))." -ForegroundColor Yellow
    exit 0
}
Write-Host "Build finished successfully." -ForegroundColor Green
