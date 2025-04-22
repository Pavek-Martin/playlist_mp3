cls

<#
------------------- specifikace m3u

Skr�t
Obsah

    (�vod)
    Specifikace
    Reference

M3U

    �l�nek
    Diskuse

    ��st
    Editovat
    Editovat zdroj
    Zobrazit historii

N�stroje

M3U je form�t soubor� ur�en� na uchov�v�n� playlist�. P�vodn� byl vyvinut� pro program Winamp, ale dnes pat�� k nejroz���en�j��m form�t�m playlist�. Podporuj� ho aplikace XMMS, VLC media player, Windows Media Player, foobar2000, iTunes, Amarok a mnoh� dal��. Soubory maj� p��ponu .m3u. Jako MIME typ se pou��v� audio/mpegurl (doporu�en�), p��padn� audio/x-mpegurl.
Specifikace

Playlisty ve form�tu M3U jsou b�n� textov� soubory, obsahuj�c� seznam cest k hudebn�m soubor�m na ka�d�m ��dku. Cesty mohou b�t absolutn� (nap�.: C:\Hudba\Skladba.mp3) �i relativn� vzhledem k um�st�n� M3U souboru (nap�.: ..\Album\Skladba.mp3).

P��klad z�kladn�ho M3U playlistu:

Skladba 1.mp3
C:\Hudba\Umelec\Album\Skladba 2.mp3
http://www.webstranka.sk:8000/radio.mp3

Existuje i roz���en� verze M3U, v n� jsou krom� soubor� ukl�d�ny tak� inform�ce o d�lce, autorovi a n�zvu skladby. Tyto soubory jsou ozna�eny hlavi�kou #EXTM3U na prvn�m ��dku a p�ed ka�d�m n�zvem souboru je uveden� popisuj�c� ��dek ve tvaru #EXTINF:<d�lka v sekund�ch>,<popis souboru>.

P��klad roz���en�ho M3U playlistu:

#EXTM3U
#EXTINF:251,N�jak� autor - Skladba 1
Skladba 1.mp3
#EXTINF:251,Jin� autor - Skladba 2
C:\Hudba\Umelec\Album\Skladba 2.mp3
#EXTINF:-1,Moje obl�ben� on-line r�dio
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


