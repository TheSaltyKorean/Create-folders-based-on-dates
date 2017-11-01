. .\Get-FileMetaDataReturnObject.ps1

$SourceDir = "C:\Users\RandyWalker\OneDrive\SkyDrive camera roll\"
$DestinationDir = "C:\Users\RandyWalker\OneDrive\SkyDrive camera roll\"

$FileMetaData = Get-FileMetaData -SourceDir $SourceDir

foreach ($file in $FileMetaData) 
{

    $Dir = $DestinationDir + $file.CreationTime.ToString("yyyy-MM-dd")
    $FullDestinationDir

    if (!(Test-Path $Dir))
    {
        Write-Host "Created Directory : " $DestinationDir $Dir
        New-Item $Dir -type directory
    }

    Write-Host "Moving file : " $file.fullname " to " $Dir
    Move-Item $file.fullname $Dir
} 