$ErrorActionPreference = 'Stop'
$moduleName = "KpInfo"

# Ensure the module is not already installed
if (!(Get-Module -ListAvailable -Name $moduleName)) {
    # Save the NuGet package containing the module to a temporary folder
    $tempFolder = New-Item -ItemType Directory -Path (Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString()))
    $nugetConfigPath = "$(Build.Repository.LocalPath)\nuget.config"
    & "nuget.exe" install $moduleName -ExcludeVersion -OutputDirectory $tempFolder -ConfigFile $nugetConfigPath
    
    # Import the module from the saved NuGet package
    $moduleFolder = Get-ChildItem -Path $tempFolder -Directory | Select-Object -First 1
    $modulePath = Join-Path $moduleFolder.FullName "$moduleName.psm1"
    Import-Module -Name $modulePath -Verbose
}