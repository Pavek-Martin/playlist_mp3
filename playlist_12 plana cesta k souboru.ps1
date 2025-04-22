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

