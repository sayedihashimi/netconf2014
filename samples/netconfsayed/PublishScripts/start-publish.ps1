﻿.\Publish-WebApplicationWebsite.ps1 -Configuration .\Configurations\netconfsayed-WAWS-dev.json -WebDeployPackage ..\netconfsayed\obj\publish\netconfsayed.zip
start http://netconfsayed.azurewebsites.net