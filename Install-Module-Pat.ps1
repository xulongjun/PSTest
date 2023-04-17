
$patToken = "$('vep3qcbpsrhmp5s6wa4zo4rgbxpexrk7rzgzqkpj5pgtwbjs3erq')" | ConvertTo-SecureString -AsPlainText -Force

$credsAzureDevopsServices = New-Object System.Management.Automation.PSCredential("longjun xu", $patToken)

Register-PSRepository -Name "PowershellAzureDevopsServices" -SourceLocation "https://pkgs.dev.azure.com/xulongjunfr//_packaging/psModule/nuget/v2" -InstallationPolicy Trusted -Credential $credsAzureDevopsServices

# Unregister-PSRepository -Name "PowershellAzureDevopsServices"
Get-PSRepository

Find-Module -Repository PowershellAzureDevopsServices -Credential $credsAzureDevopsServices

Install-Module -Name KpInfo -Repository PowershellAzureDevopsServices -Credential $credsAzureDevopsServices

Get-Module -ListAvailable KpInfo

