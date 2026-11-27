param(
    [ValidateSet('Neuro', 'Evil')]
    [string]$Mascot = 'Neuro'
)

$ErrorActionPreference = 'Stop'
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Get-JavaInfo([string]$javaPath) {
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        return (& $javaPath -version 2>&1 | Out-String)
    } finally {
        $ErrorActionPreference = $previousPreference
    }
}

function Show-ErrorMessage([string]$message) {
    Write-Host $message
    try {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            $message,
            'Shimeji launch failed',
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    } catch {
        Write-Error $message
    }
}

try {
    $root = Join-Path $scriptRoot $Mascot
    $candidatePaths = New-Object 'System.Collections.Generic.List[string]'
    $is64BitWindows = ($env:PROCESSOR_ARCHITEW6432 -match '64|ARM64') -or
        ($env:PROCESSOR_ARCHITECTURE -match '64|ARM64')
    $expectedBitness = if ($is64BitWindows) { '64' } else { '32' }
    $bundledArchitecture = if ($is64BitWindows) { 'windows-x64' } else { 'windows-x86' }
    $runtimeArchive = if ($is64BitWindows) {
        'OpenJDK8U-jre_x64_windows_hotspot_8u512b09.zip'
    } else {
        'OpenJDK8U-jre_x86-32_windows_hotspot_8u472b08.zip'
    }
    $runtimeFolder = if ($is64BitWindows) { 'jdk8u512-b09-jre' } else { 'jdk8u472-b08-jre' }
    $runtimeRoot = Join-Path $env:LOCALAPPDATA "Neuro-Evil-Desktop-Pet\runtime\$bundledArchitecture"
    $bundledJava = Join-Path $runtimeRoot "$runtimeFolder\bin\java.exe"

    if (-not (Test-Path -LiteralPath $bundledJava)) {
        $archivePath = Join-Path $scriptRoot "runtime\$runtimeArchive"
        if (Test-Path -LiteralPath $archivePath) {
            if (-not (Get-Command Expand-Archive -ErrorAction SilentlyContinue)) {
                throw 'Windows PowerShell 5.1 or later is required to unpack the bundled Java runtime.'
            }
            New-Item -ItemType Directory -Force -Path $runtimeRoot | Out-Null
            Expand-Archive -LiteralPath $archivePath -DestinationPath $runtimeRoot -Force
        }
    }

    if (Test-Path -LiteralPath $bundledJava) {
        $candidatePaths.Add($bundledJava)
    }

    $javaHome = [Environment]::GetEnvironmentVariable('JAVA_HOME')
    if ($javaHome) {
        $candidatePaths.Add((Join-Path $javaHome 'bin\java.exe'))
    }

    foreach ($pattern in @(
        (Join-Path $env:ProgramFiles 'Java\jre1.8*\bin\java.exe'),
        (Join-Path $env:ProgramFiles 'Java\jdk1.8*\bin\java.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'Java\jre1.8*\bin\java.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'Java\jdk1.8*\bin\java.exe')
    )) {
        Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue |
            Where-Object { -not $_.PSIsContainer } |
            ForEach-Object { $candidatePaths.Add($_.FullName) }
    }

    $where = Join-Path $env:SystemRoot 'System32\where.exe'
    if (Test-Path -LiteralPath $where) {
        & $where java.exe 2>$null | ForEach-Object { $candidatePaths.Add($_) }
    }

    $java8Link = Join-Path ${env:ProgramFiles(x86)} 'Common Files\Oracle\Java\java8path\java.exe'
    if ($java8Link) { $candidatePaths.Add($java8Link) }

    $java = $null
    $seen = @{}

    foreach ($candidate in $candidatePaths) {
        if (-not $candidate -or $seen.ContainsKey($candidate) -or -not (Test-Path -LiteralPath $candidate)) {
            continue
        }
        $seen[$candidate] = $true
        $details = Get-JavaInfo $candidate
        $is64BitJava = $details -match '64-Bit'
        $matchesBitness = if ($is64BitWindows) { $is64BitJava } else { -not $is64BitJava }
        if ($details -match 'version "1\.8\.' -and
            $matchesBitness) {
            $java = $candidate
            break
        }
    }

    if (-not $java) {
        Show-ErrorMessage "Java 8 ($expectedBitness-bit) could not be unpacked or found. Verify the complete repository folder and Windows PowerShell 5.1 installation."
        exit 1
    }

    $settingsPath = Join-Path $root 'conf\settings.properties'
    $settings = [System.IO.File]::ReadAllText($settingsPath)
    if ($settings -match '(?m)^Language=.*$') {
        $settings = [regex]::Replace($settings, '(?m)^Language=.*$', 'Language=zh-CN')
    } else {
        $settings += "`r`nLanguage=zh-CN"
    }
    [System.IO.File]::WriteAllText($settingsPath, $settings, [System.Text.Encoding]::ASCII)

    $javaw = Join-Path (Split-Path -Parent $java) 'javaw.exe'
    if (-not (Test-Path -LiteralPath $javaw)) { $javaw = $java }
    Start-Process -FilePath $javaw -WorkingDirectory $root -ArgumentList @(
        '-Duser.language=zh',
        '-Duser.country=CN',
        '-jar',
        'Shimeji-ee.jar'
    )
} catch {
    Show-ErrorMessage $_.Exception.Message
    exit 1
}
