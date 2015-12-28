if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}
. 'C:\tools\poshgit\dahlbyk-posh-git-869d4c5\profile.example.ps1'
Rename-Item Function:\Prompt PoshGitPrompt -Force
function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt
if ($env:ConEmuBaseDir -ne $null) {
    $current = 
    ConEmuC64 -StoreCWD "$((Get-Location).ProviderPath)"
}}
Import-Module PSReadLine

#region PSReadLine options
Set-PSReadLineOption -HistorySearchCursorMovesToEnd 
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
#endregion

#region PSReadLine bindings

Set-PSReadlineKeyHandler -Key Alt+w `
                         -BriefDescription SaveInHistory `
                         -LongDescription "Save current line in history but do not execute" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [PSConsoleUtilities.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [PSConsoleUtilities.PSConsoleReadLine]::AddToHistory($line)
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
}

$global:PSReadlineMarks = @{}

Set-PSReadlineKeyHandler -Key Ctrl+Shift+j `
                         -BriefDescription MarkDirectory `
                         -LongDescription "Mark the current directory" `
                         -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey($true)
    $global:PSReadlineMarks[$key.KeyChar] = $pwd
}

Set-PSReadlineKeyHandler -Key Ctrl+j `
                         -BriefDescription JumpDirectory `
                         -LongDescription "Goto the marked directory" `
                         -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey()
    $dir = $global:PSReadlineMarks[$key.KeyChar]
    if ($dir)
    {
        cd $dir
        [PSConsoleUtilities.PSConsoleReadLine]::InvokePrompt()
    }
}

Set-PSReadlineKeyHandler -Key Alt+j `
                         -BriefDescription ShowDirectoryMarks `
                         -LongDescription "Show the currently marked directories" `
                         -ScriptBlock {
    param($key, $arg)

    $global:PSReadlineMarks.GetEnumerator() | % {
        [PSCustomObject]@{Key = $_.Key; Dir = $_.Value} } |
        Format-Table -AutoSize | Out-Host

    [PSConsoleUtilities.PSConsoleReadLine]::InvokePrompt()
}

Set-PSReadlineKeyHandler -Key Ctrl+d `
                         -BriefDescription Get-ChildItem `
                         -LongDescription "Get the current location's child items" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("dir")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+u `
                         -BriefDescription SetLocationToParent `
                         -LongDescription "Set the current location to the parent directory" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("cd ..")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+s `
                         -BriefDescription GitStatus `
                         -LongDescription "Execute git status" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git status")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+p `
                         -BriefDescription GitPullRebase `
                         -LongDescription "Execute git pull --rebase" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git pull --rebase")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+d `
                         -BriefDescription GitDifftool `
                         -LongDescription "Execute git difftool --no-prompt" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git difftool --no-prompt")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+b `
                         -BriefDescription GitBranch `
                         -LongDescription "Execute git branch" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git branch")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+c `
                         -BriefDescription GitCommit `
                         -LongDescription "Execute git commit --verbose" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git commit --verbose")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+a `
                         -BriefDescription GitCommitAdd `
                         -LongDescription "Execute git commit --verbose -a" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git commit --verbose -a")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+u `
                         -BriefDescription GitPush `
                         -LongDescription "Execute git push" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git push")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+l `
                         -BriefDescription GitLog `
                         -LongDescription "Execute git log --graph" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git log --graph")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+f `
                         -BriefDescription GitDiff `
                         -LongDescription "Execute git diff" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git diff")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+k `
                         -BriefDescription Gitk `
                         -LongDescription "Execute gitk" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("gitk")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadlineKeyHandler -Key Ctrl+Alt+r `
                         -BriefDescription GitBranchRemote `
                         -LongDescription "Execute git branch -r" `
                         -ScriptBlock {
    [PSConsoleUtilities.PSConsoleReadLine]::RevertLine()
    [PSConsoleUtilities.PSConsoleReadLine]::Insert("git branch -r")
    [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}

#endregion