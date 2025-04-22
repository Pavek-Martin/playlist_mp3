cls
# generuje playlist *.m3u pro WinAmp

$ramdisk = "R:\"
[string] $cesta_2=$pwd
$cesta = $cesta_2
if ($cesta_2.Length -ne 3 ){ $cesta_2+='\' }

#echo $cesta
#echo $cesta_2

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
#echo $nalezeno_adresar_nazev
$m3u_file_name = "_" # prida lomitko na zacetek nazvu playlistu
$m3u_file_name+= $cesta.Substring($nalezeno_adresar_nazev,$cesta.Length - $nalezeno_adresar_nazev)
$m3u_file_name+=".m3u"

# smaze stary soubor playlistu
Remove-Item -Path $m3u_file_name -Force -ErrorAction SilentlyContinue
sleep 1


$pole_pripony = @("*.flac" ,"*.ogg" ,"*.mp3" ,"*.mod" ,"m4a")

$files = @(Get-ChildItem -Path $cesta_2 *.* -Include $pole_pripony -Name) | Sort-Object
#echo $files

# slozi pole pro export do *.m3u souboru, presne pro Winamp
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

# hlavicka *.m3u (vzdy stejna )
$obsah_m3u = @("#EXTM3U")
# konec hlavicky

for ( $bb = 0; $bb -le $files.Length -1; $bb++){
$file = $files[$bb]
#echo $file
$nalezeno_rozdelovac = $file.IndexOf(".")
#echo $nalezeno_rozdelovac
$file_2 = $file.Substring(0,$nalezeno_rozdelovac)
#echo $file_2"<"

# radek zobrazovany nazev souboru ( bez .mp3, flac apod )
#$vloz_1 = "#EXTINF:," JAK ZJISTITE DELKU SOUBORU VE VTERINACH ????
#EXTINF:280,1993 - Dveøe do pokoje ( 280 je delka *.mp3 ve vterinach a 1993 je rok skladby, pridal Winamp sam do playlistu
$vloz_1 = "#EXTINF:"
$vloz_1+= $file_2
$obsah_m3u += $vloz_1

# radek cesta a soubor
$vloz_2 = $cesta_2
$vloz_2+= $file
$obsah_m3u += $vloz_2
}

echo $obsah_m3u

#Set-Content -Path "$cesta_2$m3u_file_name" -Encoding UTF8 -Value $obsah_m3u
#Set-Content -Path "$cesta_2$m3u_file_name" -Encoding Default -Value $obsah_m3u # -Encode String funguje ve WinAmpu !!
Set-Content -Path "$ramdisk$m3u_file_name" -Encoding Default -Value $obsah_m3u # -Encode String funguje ve WinAmpu !!

# HELP - Unknown, String, Unicode, Byte, BigEndianUnicode, UTF8, UTF7, UTF32, Ascii, Default, Oem, BigEndianUTF32"
# POZOR kodovani originalniho playlistu vytvoreneho WinAmpem je CP 1250 !!!
# je potreba prevect vysledny soubor do ANSI formatu v poznamkovem bloku napr.

echo ""
#Write-Host -ForegroundColor Yellow "$cesta_2$m3u_file_name"
Write-Host -ForegroundColor Yellow "$ramdisk$m3u_file_name"
sleep 2
