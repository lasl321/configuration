Import-Module 'C:\ProgramData\Chocolatey\lib\psake.4.3.2\tools\psake.psm1'
Import-Module PsGet
Import-Module 'C:\Users\luiss\Documents\WindowsPowerShell\Modules\Jump.Location\Jump.Location.psd1'

. (Join-Path $PSScriptRoot 'EnvironmentVariables.ps1')
. (Join-Path $PSScriptRoot 'Helpers.ps1')

Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Git\cmd')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Git\bin')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'GitExtensions')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'nodejs')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'MSBuild\12.0\Bin\amd64')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio 12.0\Common7\IDE')
Add-DirectoryToPath (Join-Path $env:ProgramW6432 'Microsoft\Web Platform Installer')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools')
Add-DirectoryToPath (Join-Path $env:ProgramW6432 'Microsoft SDKs\Azure\.NET SDK\v2.5\bin\')

Set-Alias -Name p -Value Invoke-psake
Set-Alias -Name npp 'C:\Program Files (x86)\Notepad++\notepad++.exe'
Set-Alias -Name nu 'C:\tools\NUnit-2.6.3\bin\nunit-console.exe'
Set-Alias -Name hub 'C:\tools\hub-windows-amd64-2.2.0\hub.exe'
Set-Alias -Name inspectcode 'C:\Users\luiss\Tools\JetBrains.ReSharper.CommandLineTools.9.1.20150408.154812\inspectcode.exe'
Set-Alias -Name apm 'C:\Users\luiss\AppData\Local\atom\bin\apm.cmd'
Set-Alias -Name atom 'C:\Users\luiss\AppData\Local\atom\bin\atom.cmd'

Set-Alias -Name crb Invoke-CleanRestoreBuild
Set-Alias -Name npr New-PullRequest
Set-Alias -Name gpr Get-PullRequests

