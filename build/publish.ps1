$PSRoot = $PSScriptRoot
$APIKey = gc "$PSRoot\..\usr\APIKey.txt"

. "$PSRoot\vsts-build.ps1" -ApiKey $APIKey -Repository PSGallery
