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


$play_file = "play.bat"
Remove-Variable $b -ErrorAction SilentlyContinue
[string] $b=$pwd
$b+='\'
$b+=$play_file
#echo $b"--"

#Get-ChildItem *.* -include *.flac,*.ogg,*.mp3 -name | Out-File -Encoding UTF8 00-playlist.m3u
Get-ChildItem *.* -include *.flac,*.ogg,*.mp3 -name | Out-File -Encoding UTF8 playlist.m3u
#sleep 1

# dir /B /ON *.mp3 > list.m3u
# uplne to samy ale  v cmd.exe


$soubor = @(
"@echo off"
"type playlist.m3u"
"mpv --playlist=playlist.m3u"
"pause"
)


Set-Content -Path $b -Encoding ASCII -Value $soubor


