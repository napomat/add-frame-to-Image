## ImageMagic binary ##
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$imgmagic = $scriptDir+"\ImageMagick-7.0.10-53\"

################Variables################
$Bordersize = 20
########



$Folder = $null
$Files = $null
$File = $null

Function Get-Folder($initialDirectory="")

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    Write-Host -ForegroundColor Red -BackgroundColor Yellow  "`t`tW A R N I N G :   Dialog box may be hidden behind another [or this] window!!!" 

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$Folder = Get-Folder
If(!(test-path $Folder\with_border))
{
  mkdir $Folder\with_border
}


$Files = Get-ChildItem $Folder -Filter "*.jpg"

foreach($File in $Files){

  ##Filename
  $outname = $File.Name.ToString()+"_"+$(Get-Date).Ticks.ToString() + ".jpg"

  ## Image Magic
  #. $imgmagic\magick.exe convert $File.FullName -set option:distort:scale 2:3 $Folder\with_border\temp.jpg
  #. $imgmagic\magick.exe convert $Folder\with_border\temp.jpg -bordercolor white -border 40x40  $Folder\with_border\$outname

  $ratio = . $imgmagic\magick.exe identify -format "%[fx:w]x%[fx:h]" $File.FullName

  $ratiosplit = $ratio.split("x")

  if ($ratiosplit[0] -lt $ratiosplit[1]){
    . $imgmagic\magick.exe convert $File.FullName -gravity center -crop 2:3  $Folder\with_border\temp.jpg
    . $imgmagic\magick.exe convert $Folder\with_border\temp.jpg -shave $Bordersize -bordercolor white -border $Bordersize $Folder\with_border\$outname
  }
  else{
    . $imgmagic\magick.exe convert $File.FullName -gravity center -crop 3:2 $Folder\with_border\temp.jpg
    . $imgmagic\magick.exe convert $Folder\with_border\temp.jpg -shave $Bordersize -bordercolor white -border $Bordersize  $Folder\with_border\$outname
  }

  remove-item $Folder\with_border\temp.jpg

}
Invoke-Item $Folder\with_border

