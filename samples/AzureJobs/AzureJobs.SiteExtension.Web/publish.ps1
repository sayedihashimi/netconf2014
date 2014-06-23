[cmdletbinding()]
param(
    $imgOptPassword,
    $textMinPassword
)
function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
$scriptDir = ((Get-ScriptDirectory) + "\")

if(!$imgOptPassword){ $imgOptPassword = $env:imgOptPassword }
if(!$textMinPassword){ $textMinPassword = $env:textMinPassword }

$projToBuild = get-item (Join-Path $scriptDir 'AzureJobs.SiteExtension.Web.csproj')

#Set-Alias msbuild ('{0}\MSBuild\12.0\bin\amd64\msbuild.exe' -f ${env:ProgramFiles(x86)})

$msbuildArgs = @()
$msbuildArgs += $projToBuild.FullName
$msbuildArgs += '/p:VisualStudioVersion=12.0'
$msbuildArgs += '/p:Configuration=Release'
$msbuildArgs += '/p:DeployOnBuild=true'
$msbuildArgs += '/p:PublishProfile=imgopt'
$msbuildArgs += ('/p:Password={0}' -f $imgOptPassword)

"Calling msbuild.exe with the following args: {0}" -f ($msbuildArgs -join ' ') | Write-Output

msbuild $msbuildArgs

$msbuildArgs = @()
$msbuildArgs += $projToBuild.FullName
$msbuildArgs += '/p:VisualStudioVersion=12.0'
$msbuildArgs += '/p:Configuration=Release'
$msbuildArgs += '/p:DeployOnBuild=true'
$msbuildArgs += '/p:PublishProfile=textmin'
$msbuildArgs += ('/p:Password={0}' -f $textMinPassword)

"Calling msbuild.exe with the following args: {0}" -f ($msbuildArgs -join ' ') | Write-Output

msbuild $msbuildArgs
