
$patToken = $env:SYSTEM_ACCESSTOKEN | ConvertTo-SecureString -AsPlainText -Force

$credsAzureDevopsServices = New-Object System.Management.Automation.PSCredential($env:SYSTEM_ACCESSTOKEN, $patToken)

Register-PSRepository -Name "PowershellAzureDevopsServices" -SourceLocation "https://pkgs.dev.azure.com/xulongjunfr//_packaging/psModule/nuget/v2" -InstallationPolicy Trusted -Credential $credsAzureDevopsServices

# Unregister-PSRepository -Name "PowershellAzureDevopsServices"
Get-PSRepository

Find-Module -Repository PowershellAzureDevopsServices -Credential $credsAzureDevopsServices

Install-Module -Name KpInfo -Repository PowershellAzureDevopsServices -Credential $credsAzureDevopsServices

Get-Module -ListAvailable KpInfo

