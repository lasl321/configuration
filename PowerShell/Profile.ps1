Import-Module 'C:\ProgramData\Chocolatey\lib\psake.4.3.2\tools\psake.psm1'
Import-Module PsGet
Import-Module 'C:\Users\luiss\Documents\WindowsPowerShell\Modules\Jump.Location\Jump.Location.psd1'

$env:NUNIT = 'C:\tools\NUnit-2.6.3\bin\nunit-console.exe'
$env:NUGET = 'C:\ProgramData\Chocolatey\bin\NuGet.exe'
$env:ROBOCOPY = (Join-Path (Join-Path $env:SystemRoot 'system32') 'robocopy.exe')

. (Join-Path $PSScriptRoot 'Helpers.ps1')

Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Git\cmd')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Git\bin')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'GitExtensions')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'nodejs')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'MSBuild\12.0\Bin\amd64')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio 12.0\Common7\IDE')
Add-DirectoryToPath (Join-Path $env:ProgramW6432 'Microsoft\Web Platform Installer')
Add-DirectoryToPath (Join-Path ${env:ProgramFiles(x86)} 'Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools')
Add-DirectoryToPath (Join-Path $env:ProgramW6432 'Microsoft SDKs\Azure\.NET SDK\v2.7\bin\')
Add-DirectoryToPath 'C:\tools\redis-x64-2.8.21'
Add-DirectoryToPath 'C:\tools\apache-jmeter-2.13\bin'

Set-Alias -Name p -Value Invoke-psake
Set-Alias -Name npp 'C:\Program Files (x86)\Notepad++\notepad++.exe'
Set-Alias -Name nu 'C:\tools\NUnit-2.6.3\bin\nunit-console.exe'
Set-Alias -Name hub 'C:\tools\hub-windows-amd64-2.2.0\hub.exe'
Set-Alias -Name inspectcode 'C:\Users\luiss\Tools\JetBrains.ReSharper.CommandLineTools.9.1.20150408.154812\inspectcode.exe'

Set-Alias -Name crb Invoke-CleanRestoreBuild