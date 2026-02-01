param(
    [string]$DocName = "Dissertation"
)

$ErrorActionPreference = "Stop"

# Define separate build directories to prevent file conflicts during parallel execution
$DirDigital = "build_digital"
$DirPrint = "build_print"

function Invoke-Cleanup {
    Write-Host "Cleaning temporary files..."
    # Clean specific build directories using latexmk
    # We ignore errors because latexmk returns error if no files are found to clean
    #try { latexmk -c -outdir=$DirDigital $DocName *>$null } catch {}
    #try { latexmk -c -outdir=$DirPrint "${DocName}_print" *>$null } catch {}
    if (Test-Path $DirDigital) { Remove-Item $DirDigital -Recurse -Force | Out-Null }
    if (Test-Path $DirPrint) { Remove-Item $DirPrint -Recurse -Force | Out-Null }
}

# Cleanup beforehand
#Invoke-Cleanup

# Get current location to pass to jobs
$CurrentDir = Get-Location

# Define build blocks
$BlockDigital = {
    param($DocName, $Dir, $WorkDir)
    Set-Location $WorkDir
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
    Write-Host "Building Digital Version..."
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -xelatex "-outdir=$Dir" "-jobname=$DocName" "$DocName.tex"
}

$BlockPrint = {
    param($DocName, $Dir, $WorkDir)
    Set-Location $WorkDir
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
    Write-Host "Building Print Version..."
    # Command to define PRINTABLE
    $latexCmd = "xelatex %O \def\PRINTABLE{} \input{%S}"
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -xelatex "-outdir=$Dir" "-jobname=${DocName}_print" -e "`$xelatex = '$latexCmd'" "$DocName.tex"
}

# Start parallel jobs
Write-Host "Starting parallel builds..."
$jobDig = Start-Job -ScriptBlock $BlockDigital -ArgumentList $DocName, $DirDigital, $CurrentDir
$jobPrt = Start-Job -ScriptBlock $BlockPrint -ArgumentList $DocName, $DirPrint, $CurrentDir

$jobs = $jobDig, $jobPrt

# Wait for jobs to complete
Wait-Job -Job $jobs | Out-Null

# Reset ErrorActionPreference to ensure script continues even if jobs reported errors
$ErrorActionPreference = "Continue"

# Output results
foreach ($j in $jobs) {
    Receive-Job -Job $j
}

# Get current date in YYMMDD format
$DatePrefix = Get-Date -Format "yyMMdd"

# Move PDFs to root
if (Test-Path "$DirDigital\$DocName.pdf") { Move-Item "$DirDigital\$DocName.pdf" ".\${DatePrefix}_${DocName}.pdf" -Force }
if (Test-Path "$DirPrint\${DocName}_print.pdf") { Move-Item "$DirPrint\${DocName}_print.pdf" ".\${DatePrefix}_${DocName}_print.pdf" -Force }

# Cleanup after
Invoke-Cleanup
Remove-Job -Job $jobs
