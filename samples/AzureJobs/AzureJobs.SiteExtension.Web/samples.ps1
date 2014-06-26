# This contains a few different samples, you can manually invoke these in PS ISE. 
# This script shouldn't be invoked directly
exit

# CD to the project directory before invoking the funcitons below

# Set-Alias msbuild ('{0}\MSBuild\12.0\bin\amd64\msbuild.exe' -f ${env:ProgramFiles(x86)})


# How to use a publish profile and use that to create a web deploy package?
# After invoking a package is created at AzureJobs.SiteExtension.Web\obj\Debug\Package 
# that includes the extra files via .pubxml
msbuild .\AzureJobs.SiteExtension.Web.csproj /p:VisualStudioVersion=12.0 /p:DeployOnBuild=true /p:PublishProfile=imgopt-extrafiles /p:WebPublishMethod=Package /fl

