$SourceDir = "C:\Users\RandyWalker\Desktop\Pictures\"
$DestinationDir = "C:\Users\RandyWalker\Desktop\FolderPictures\"

foreach ($file in get-childitem $SourceDir *.*) 
{
    $Directory = $DestinationDir + $file.LastWriteTime.ToString("yyyy-MM-dd")
    $FullDestinationDir

    if (!(Test-Path $Directory))
    {
        Write-Host "Created Directory : " $DestinationDir $directory
        New-Item $directory -type directory
    }

    Write-Host "Moving file : " $file.fullname " to " $directory
    Move-Item $file.fullname $directory
} 