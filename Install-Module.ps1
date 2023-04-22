param 
(
    $accessToken,
    $moduleName,
    $sourceName,
    $feedLocation
)

# local test
# $accessToken = "33v2eejfsjckirgz2puagcxdqzcv5uqzmybmbeyyktdfxsdnwocq"
# $moduleName = "KpInfo"
# $sourceName = "PsModuleTest" #4
# $feedLocation = "https://pkgs.dev.azure.com/xulongjunfr/LongjunTest/_packaging/PsModuleTest/nuget/v2"

# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 #1

if (-not (Get-Module -Name $moduleName -ListAvailable)) 
{
    Write-Host "moduleName not found : $moduleName"

    $token = $accessToken | ConvertTo-SecureString -AsPlainText -Force #2
    $credential = New-Object System.Management.Automation.PSCredential($accessToken, $token) #3

    if (-not (Get-PackageSource -name $sourceName -ErrorAction SilentlyContinue)) {
         Write-Host "sourceName not found : $sourceName"
         Register-PackageSource -Name $sourceName -ProviderName PowerShellGet -Location $feedLocation -Trusted -Credential $credential #6
    }

    Install-Module -Name $moduleName -Repository $sourceName -Force -Credential $credential #8
    Write-Host "Install-Module : $moduleName"
    # $pathNuget = (get-item $PSScriptRoot).Parent.Parent.FullName
}
    Get-Module -ListAvailable -Name $moduleName
    import-Module $moduleName

    Get-KpICatFact

# Remove-Module -Name "KpInfo"
# Uninstall-Module -Name "KpInfo"  -AllVersions