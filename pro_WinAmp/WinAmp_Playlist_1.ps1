cls

<#
#EXTM3U
#EXTINF:Žádné nové zprávy
R:\01 - Žádné nové zprávy.mp3
#EXTINF:Dveøe do pokoje
R:\02 - Dveøe do pokoje.mp3
#EXTINF:Malý obr aneb Jako letadlo
R:\03 - Malý obr aneb Jako letadlo.mp3

atd.

#>

[string] $cesta_2=$pwd
$cesta = $cesta_2
if ($cesta_2.Length -ne 3 ){ $cesta_2+='\' }

echo $cesta
echo $cesta_2

$nalezeno_adresar_nazev = 0 
for ( $aa = $cesta.Length -1; $aa -ne 0; $aa--){
#echo $aa
$znak = $cesta.Substring($aa,1)

if ( $znak -like "\" ) {
$nalezeno_adresar_nazev = $aa
break
}
}

$nalezeno_adresar_nazev++ # musi bejt

#echo $cesta
#echo $nalezeno_adresar_nazev_nazev

#echo $cesta.Substring($nalezeno_adresar_nazev+1,$cesta.Length - $nalezeno_adresar_nazev-1)
$m3u_file_name = $cesta.Substring($nalezeno_adresar_nazev,$cesta.Length - $nalezeno_adresar_nazev)
$m3u_file_name+=".m3u"

echo $m3u_file_name



Remove-Item -Path $file_playlist_m3u -Force -ErrorAction SilentlyContinue
sleep 1

$pole_include = @("*.flac" ,"*.ogg" ,"*.mp3" ,"*.mod" ,"m4a")

$files = @(Get-ChildItem -Path $b2 *.* -Include $pole_include -Name)
#echo $files

$file_obsah_m3u = @()

for ($aa = 0; $aa -le $files.Length -1; $aa++){
$vloz = $b2
$vloz += $files[$aa]
echo $vloz
$file_obsah_m3u += $vloz
}

Set-Content -Path "$b2$file_playlist_m3u" -Encoding UTF8 -Value $file_obsah_m3u

sleep 1

$soubor_play_bat = @(
"@echo off"
"type playlist.m3u"
"mpv --playlist=playlist.m3u"
"pause"
)


Set-Content -Path $b -Encoding ASCII -Value $soubor_play_bat
sleep 1

