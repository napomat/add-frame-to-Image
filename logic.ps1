## ImageMagic binary ##
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$imgmagic = $scriptDir+"\ImageMagick-7.0.10-53\"
$BordersizeA =  $null
$BordersizeB =  $null
$Bordercolor =  $null
$aspectratioA = $null
$aspectratioB = $null 
$Folder = $null
$Files = $null
$File = $null

Write-Host -ForegroundColor Red -BackgroundColor Yellow  "`t`t Bitte das Seitenverhaeltnis waehlen!"
$aspectratioselect = Read-Host -Prompt "0 = 7x5 , 1 = 7x9.5 , 2 = 7x7 , 3 = 9.5x14.5 " 


################Variables################

switch ( $aspectratioselect ){
  0 { # 7x5,5
    $BordersizeA = "97x77.6"
    $BordersizeB = "77.6x97"
    $Bordercolor = "#eae4dd"
    $aspectratioA = "1:0.78"
    $aspectratioB = "0.78:1"  }
  1 { #7x9,5
    $BordersizeA = "97x71,78"
    $BordersizeB = "71,78x97"
    $Bordercolor = "#eae4dd"
    $aspectratioA = "1:0,74"
    $aspectratioB = "0,74:1"  }
  2 { # 7x7
    $BordersizeA = "97x97"
    $BordersizeB = "97x97"
    $Bordercolor = "#eae4dd"
    $aspectratioA = "1:1"
    $aspectratioB = "1:1"  }
  3 { # 9,5x14,5
    $BordersizeA = "97x63.05"
    $BordersizeB = "63.05x97"
    $Bordercolor = "#eae4dd"
    $aspectratioA = "0.65:1"
    $aspectratioB = "1:0.65" }
}



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

  $ratio = . $imgmagic\magick.exe identify -format "%[fx:w]x%[fx:h]" $File.FullName

  $ratiosplit = $ratio.split("x")

  if ($ratiosplit[0] -lt $ratiosplit[1]){
    . $imgmagic\magick.exe convert $File.FullName -gravity center -crop $aspectratioA $Folder\with_border\temp.jpg
    . $imgmagic\magick.exe convert $Folder\with_border\temp.jpg  -bordercolor $Bordercolor -border $BordersizeB $Folder\with_border\$outname
  }
  else{
    . $imgmagic\magick.exe convert $File.FullName -gravity center -crop $aspectratioB $Folder\with_border\temp.jpg
    . $imgmagic\magick.exe convert $Folder\with_border\temp.jpg -bordercolor $Bordercolor -border $BordersizeA $Folder\with_border\$outname
  }

remove-item $Folder\with_border\temp.jpg

}
Invoke-Item $Folder\with_border

