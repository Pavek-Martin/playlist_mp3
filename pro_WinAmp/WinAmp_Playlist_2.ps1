cls
# generuje playlist *.m3u pro WinAmp

[string] $cesta_2=$pwd
$cesta = $cesta_2
if ($cesta_2.Length -ne 3 ){ $cesta_2+='\' }

echo $cesta
echo $cesta_2

$nalezeno_adresar_nazev = 0 
for ( $aa = $cesta.Length -1; $aa -ne 0; $aa--){ # jede od zadu a hleda prvni lomitka
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
$m3u_file_name = $cesta.Substring($nalezeno_adresar_nazev,$cesta.Length - $nalezeno_adresar_nazev)
$m3u_file_name+=".m3u"
echo $m3u_file_name


# smaze stary soubor playlistu
Remove-Item -Path $m3u_file_name -Force -ErrorAction SilentlyContinue
sleep 1

$pole_pripony = @("*.flac" ,"*.ogg" ,"*.mp3" ,"*.mod" ,"m4a")

$files = @(Get-ChildItem -Path $cesta_2 *.* -Include $pole_pripony -Name)
#echo $files

# slozi pole pro export do *.m3u souboru, presne pro Winamp
<#
#EXTM3U
#EXTINF:��dn� nov� zpr�vy
R:\01 - ��dn� nov� zpr�vy.mp3
#EXTINF:Dve�e do pokoje
R:\02 - Dve�e do pokoje.mp3
#EXTINF:Mal� obr aneb Jako letadlo
R:\03 - Mal� obr aneb Jako letadlo.mp3

atd.

#>

for ( $bb = 0; $bb -le $files.Length -1; $bb++){
$file = $files[$bb]
$nalezeno_rozdelovac = $file.IndexOf(".")
#echo $nalezeno_rozdelovac
$file_2 = $file.Substring(0,$nalezeno_rozdelovac)
echo $file_2"<"





}






exit


# hlavicka
$obsah_m3u = @()
$obsah_m3u += "#EXTM3U"
# konec hlavicky

# radek zobrazovany nazev souboru ( bez .mp3, flac apod )
$vloz_1 = "#EXTINF:"
$vloz_1+= 





exit




for ($aa = 0; $aa -le $files.Length -1; $aa++){
$vloz = $b2
$vloz += $files[$aa]
echo $vloz
$file_obsah_m3u += $vloz
}

Set-Content -Path "$b2$file_playlist_m3u" -Encoding UTF8 -Value $file_obsah_m3u

sleep 1


<#
$soubor_play_bat = @(
"@echo off"
"type playlist.m3u"
"mpv --playlist=playlist.m3u"
"pause"
)


Set-Content -Path $b -Encoding ASCII -Value $soubor_play_bat
sleep 1

#>


