cls

<#
------------------- specifikace m3u

Skrýt
Obsah

    (úvod)
    Specifikace
    Reference

M3U

    Èlánek
    Diskuse

    Èíst
    Editovat
    Editovat zdroj
    Zobrazit historii

Nástroje

M3U je formát souborù urèený na uchovávání playlistù. Pùvodnì byl vyvinutý pro program Winamp, ale dnes patøí k nejrozšíøenìjším formátùm playlistù. Podporují ho aplikace XMMS, VLC media player, Windows Media Player, foobar2000, iTunes, Amarok a mnohé další. Soubory mají pøíponu .m3u. Jako MIME typ se používá audio/mpegurl (doporuèený), pøípadnì audio/x-mpegurl.
Specifikace

Playlisty ve formátu M3U jsou bìžné textové soubory, obsahující seznam cest k hudebním souborùm na každém øádku. Cesty mohou být absolutní (napø.: C:\Hudba\Skladba.mp3) èi relativní vzhledem k umístìní M3U souboru (napø.: ..\Album\Skladba.mp3).

Pøíklad základního M3U playlistu:

Skladba 1.mp3
C:\Hudba\Umelec\Album\Skladba 2.mp3
http://www.webstranka.sk:8000/radio.mp3

Existuje i rozšíøená verze M3U, v níž jsou kromì souborù ukládány také informáce o délce, autorovi a názvu skladby. Tyto soubory jsou oznaèeny hlavièkou #EXTM3U na prvním øádku a pøed každým názvem souboru je uvedený popisující øádek ve tvaru #EXTINF:<délka v sekundách>,<popis souboru>.

Pøíklad rozšíøeného M3U playlistu:

#EXTM3U
#EXTINF:251,Nìjaký autor - Skladba 1
Skladba 1.mp3
#EXTINF:251,Jiný autor - Skladba 2
C:\Hudba\Umelec\Album\Skladba 2.mp3
#EXTINF:-1,Moje oblíbené on-line rádio
http://www.webstranka.sk:8000/radio.mp3
#>

#Remove-Variable $b -ErrorAction Ignore ( blbnulo )

$play_bat_file = "play.bat"
#$play_bat_file = "playlist.bat"

[string] $b=$pwd
#$b+='\'
if ($b.Length -ne 3 ){ $b+='\' }
$b2=$b
$b+=$play_bat_file
#echo $b"--"

Remove-Item -Path $b -Force -ErrorAction SilentlyContinue
sleep 1

#$file_playlist_m3u = "test.txt"
$file_playlist_m3u = "playlist.m3u"
Remove-Item -Path $file_playlist_m3u -Force -ErrorAction SilentlyContinue
sleep 1

$pole_include = @("*.flac" ,"*.ogg" ,"*.mp3" ,"*.mod" ,"m4a")

$files = @(Get-ChildItem -Path $b2 *.* -Include $pole_include -Name)
#echo $files

$file_obsah_m3u = @()

for ($aa = 0; $aa -le $files.Length -1; $aa++){
$vloz = $b2
$vloz += $files[$aa]
echo $vloz"<"
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

