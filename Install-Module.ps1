param 
(
    $pathNuget,
    $moduleName = "KpInfo"
)

# $pathNuget = $PSScriptRoot

# First time
# Write-Host "Downloading nuget.exe..."
# Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile 'C:/nuget/nuget.exe'
# Write-Host "Adding nuget.exe to PATH..."
# $env:PATH += ";C:/nuget/"

# Uninstall-Module -Name "KpInfo"  -AllVersions
# Remove-Module -Name "KpInfo"

# Ensure the module is not already installed
if (!(Get-Module -ListAvailable -Name $moduleName)) {
    # Save the NuGet package containing the module to a temporary folder
    $tempFolder = New-Item -ItemType Directory -Path (Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString()))
    $nugetConfigPath = "$pathNuget\nuget.config"
    & "nuget.exe" install $moduleName -ExcludeVersion -OutputDirectory $tempFolder -ConfigFile $nugetConfigPath
    
    # Import the module from the saved NuGet package
    $moduleFolder = Get-ChildItem -Path $tempFolder -Directory | Select-Object -First 1
    $modulePath = Join-Path $moduleFolder.FullName "$moduleName.psm1"
    Import-Module -Name $modulePath -Verbose
}

Get-CatFact