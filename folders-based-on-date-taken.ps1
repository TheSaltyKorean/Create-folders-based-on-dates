#Specify the Source Directory
$SourceDir = "C:\Users\RandyWalker\OneDrive\SkyDrive camera roll\"
#Specify the Destination Directory
$DestinationDir = "C:\Users\RandyWalker\OneDrive\SkyDrive camera roll\"

#Fetching all the files under the given Source folder
$AllItems = Get-ChildItem $SourceDir -Recurse | Select-Object FullName -ExpandProperty FullName

foreach ($FileName in $AllItems) 
{

  ##Processing the file to get the DateTaken information
  $shell = New-Object -COMObject Shell.Application
  $folder = Split-Path $FileName
  $file = Split-Path $FileName -Leaf
  $shellfolder = $shell.Namespace($folder)
  $shellfile = $shellfolder.ParseName($file)
  $MetaDataProperties = 0..287 | Foreach-Object { '{0} = {1}' -f $_, $shellfolder.GetDetailsOf($null, $_) }
  $i=12
  $Property = ($MetaDataProperties[$i].split("="))[1].Trim()
  $Property = (Get-Culture).TextInfo.ToTitleCase($Property).Replace(' ', '')
  $Value = $shellfolder.GetDetailsOf($shellfile, $i)
  $DateTaken = $Value.Split(' ')[0]
  $DateTaken = $DateTaken.Split('/')
  $DateTaken = $DateTaken[2] + "-" + $DateTaken[0]+"1" + $DateTaken[1]
  
## Bug above, as it adds some spaces

  ##Creating Folder Variable
  $Directory = $DestinationDir + $DateTaken

  ##Checking if the folder already exists, if not, we will create new folder
  if (!(Test-Path $Directory))
  {
      Write-Host "Created Directory : " $DestinationDir $directory
      New-Item $Directory -type directory
  }

  Write-Host "Moving file : " $FileName " to " $directory
  ##Moving the file to the specific folder
  Move-Item -Path $FileName -Destination $Directory
  
}