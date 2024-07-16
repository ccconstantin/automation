# This script create mozilla firefox profile and save his data into C:\Users\Administrator\Documents\Clients\
# Prompt the user for the name of the new profile
$profileName = Read-Host "Enter the name of the new Firefox profile"

# Prompt the user for the directory to store the profile data (e.g., ABC or AAA)
$profileDirName = Read-Host "Enter the of the client. The folder will be created at C:\Users\Administrator\Documents\Clients\"

# Construct the full directory path based on user input
$baseDir = "C:\Users\Administrator\Documents\Clients"
$profileDir = Join-Path -Path $baseDir -ChildPath $profileDirName
$mozillaDir = Join-Path -Path $profileDir -ChildPath "Mozilla"

# Define the Firefox executable path
$firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"

# Check if the Firefox executable exists at the defined path
if (-Not (Test-Path $firefoxPath)) {
    Write-Error "Firefox executable not found at $firefoxPath. Please check the installation path."
    exit
}

# Check if the specified directory exists, if not, create it
if (-Not (Test-Path $mozillaDir)) {
    try {
        New-Item -ItemType Directory -Path $mozillaDir -Force
    } catch {
        Write-Error "Failed to create directory at $mozillaDir. Please check the path and try again."
        exit
    }
}

# Define the full profile path
$fullProfilePath = Join-Path -Path $mozillaDir -ChildPath "$profileName"

# Create a new Firefox profile using the Profile Manager with the specified path
Start-Process -FilePath $firefoxPath -ArgumentList "-CreateProfile `"$profileName $fullProfilePath`""

# Wait for the profile creation process to complete
Start-Sleep -Seconds 5

# Output the location of the new profile
Write-Output "New profile created at: $fullProfilePath"

# Launch Firefox with the new profile for verification
Start-Process -FilePath $firefoxPath -ArgumentList "-P `"$profileName`" -no-remote"

Write-Output "Firefox launched with the new profile. Please verify the profile creation."
