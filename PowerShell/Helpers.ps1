function Add-DirectoryToPath(
    [Parameter(Mandatory=$true)]
    [string] 
    $directory,

    [bool]
    $append = $true
) {
    if (Test-Path $directory) {
        if ($append) {
            $env:Path = $env:Path + ';' + $directory
        } else {
            $env:Path = $directory + ';' + $env:Path
        }
    } else {
        Write-Warning "Could not add $directory to path. Directory doesn't exist."
    }    
}

function Start-BuildServices {
    Start-Service -DisplayName 'TeamCity Server'
    Start-Service -DisplayName 'TeamCity Build Agent'
    Start-Service -DisplayName 'OctopusDeploy'
    Start-Service -DisplayName 'OctopusDeploy Tentacle'
}

function Stop-BuildServices {
    Stop-Service -DisplayName 'TeamCity Build Agent'
    Stop-Service -DisplayName 'TeamCity Server'
    Stop-Service -DisplayName 'OctopusDeploy Tentacle'
    Stop-Service -DisplayName 'OctopusDeploy'
}

function Invoke-ProfileEditor {
    Start-Process (Join-Path $PSScriptRoot 'Profile.ps1')
}

function Remove-LongPath ([Parameter(Mandatory=$true)] [string] $path) {
    $emptyDirectory = Join-Path $env:TEMP ((Get-Date).Ticks)
    
    New-Item -ItemType Directory $emptyDirectory -Force | Out-Null
    & $env:ROBOCOPY /MIR $emptyDirectory $path | Out-Null
    Remove-Item $path -Recurse -Force
    Remove-Item $emptyDirectory -ErrorAction SilentlyContinue
}

function Invoke-CleanRestoreBuild {
    git clean -fxd
    & $env:NUGET restore
    msbuild       
}

function Get-Remotes {
    git remote | % {git fetch $_ --prune} | Write-Host
}

function Remove-LocalBranches {
    git branch | % {$_.Trim()} | where {(-not $_.StartsWith('*')) -and ($_ -ne 'master')} | % {git branch -D $_} | Write-Host
}

function New-PullRequest {
    & C:\tools\hub-windows-amd64-2.2.0\hub.exe pull-request
}

function Get-PullRequests {
    & C:\tools\hub-windows-amd64-2.2.0\hub.exe browse -- pulls
}

function Get-LatestLogFile {
    dir Log.txt.* | sort LastWriteTime | select -Last 1 | % {mtail $_.FullName}
}