# This contains a few different samples, you can manually invoke these in PS ISE. 
# This script shouldn't be invoked directly

exit

# CD to the project directory before invoking the funcitons below

Set-Alias msbuild ('{0}\MSBuild\12.0\bin\amd64\msbuild.exe' -f ${env:ProgramFiles(x86)})
Set-Alias msdeploy ('{0}\IIS\Microsoft Web Deploy V3\msdeploy.exe ' -f $env:ProgramFiles)

# How to use a publish profile and use that to create a web deploy package?
# After invoking a package is created at AzureJobs.SiteExtension.Web\obj\Debug\Package 
# that includes the extra files via .pubxml
#msbuild .\AzureJobs\AzureJobs.SiteExtension.Web\AzureJobs.SiteExtension.Web.csproj /p:VisualStudioVersion=12.0 /p:DeployOnBuild=true /p:PublishProfile=imgopt-extrafiles /p:WebPublishMethod=Package /fl

# How to use a publish profile and use that to create a web deploy package?
# After invoking a package is created at AzureJobs.SiteExtension.Web\obj\Debug\Package 
# that includes the extra files via .pubxml
msbuild .\CustomParams\AzureJobs.SiteExtension.Web\AzureJobs.SiteExtension.Web.csproj /p:VisualStudioVersion=12.0 /p:DeployOnBuild=true /p:PublishProfile=topkg /p:WebPublishMethod=Package /fl

$deployArgs = @()
$deployArgs += '-verb:sync'
$deployArgs += '-source:package=C:\Data\personal\mycode\netconf2014\samples\CustomParams\AzureJobs.SiteExtension.Web\obj\publish\AzureJobs.SiteExtension.Web.zip'
$deployArgs += '-dest:auto,includeAcls="False",ComputerName="https://waws-prod-ch1-001.publish.azurewebsites.windows.net:443/msdeploy.axd?site=imgopt",Username="$imgopt",Password="HrbeLx82JewesNmbhsHcKrfuljkeZ6CmiQbiQfk0NYv6kBNevrkR7Bbkv6gx",AuthType="basic"'
$deployArgs += '-disableLink:AppPoolExtension'
$deployArgs += '-disableLink:ContentExtension'
$deployArgs += '-disableLink:CertificateExtension'
$deployArgs += '-setParamFile:"C:\Users\sayedha\AppData\Local\Temp\AzureJobs.SiteExtension.Web_zip\SetParameters.xml'


"Calling msdeploy.exe with the following args: {0}" -f ($deployArgs -join ' ') | Write-Output

&'C:\Program Files\IIS\Microsoft Web Deploy V3\msdeploy.exe' $deployArgs

