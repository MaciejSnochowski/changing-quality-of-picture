$userName=(get-childitem Env:\USERNAME).Value
$infolderPath="C:\Users\$userName\Documents\Psh\test\przed"

$allChild = Get-ChildItem $infolderPath -R | Where-Object {($_.Extension -eq ".JPG") -or ($_.Extension -eq ".jpg")}

foreach($file in $allChild)
{
   
$bmp = New-Object System.Drawing.Bitmap($file.FullName)
$date= Get-Date -Format "dddd dd.MM.yyyy"

if(-Not (Test-Path -Path "C:\Users\$userName\Documents\Psh\test\po\${date}"))
{
    New-Item -ItemType Directory -Path "C:\Users\$userName\Documents\Psh\test\po" -Name $date
}

$partialName= Get-Date -format "dddd HH-mm-ss"
$nameOfNewFile="zdjecie $partialName.jpg"
$pathOfNewFile="C:\Users\$userName\Documents\Psh\test\po\$date\$nameOfNewFile"

$myEncoder = [System.Drawing.Imaging.Encoder]::Quality
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1) 
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($myEncoder, 80)
   
$myImageCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|where {$_.MimeType -eq 'image/jpeg'}
$bmp.Save($pathOfNewFile,$myImageCodecInfo, $encoderParams)

}


