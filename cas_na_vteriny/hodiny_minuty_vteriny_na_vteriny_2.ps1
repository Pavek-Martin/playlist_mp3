cls

$cas = "00:43:57" #EXTINF:2637,filename
#       01234567

echo $cas

$hodin = $cas.Substring(0,2)
#echo $hodin
$hodin_int = [int32] $hodin
echo $hodin_int

$minut = $cas.Substring(3,2) # 3 znak a dva znaky
#echo $minut
$minut_int = [int32] $minut
echo $minut_int

$vterin = $cas.Substring(6,2)
#echo $vterin
$vterin_int = [int32] $vterin
echo $vterin_int
#

$cas_ve_vterinach = (( $hodin_int * 3600 + $minut_int * 60 + $vterin_int ))
echo "--------------------"
echo $cas_ve_vterinach
#EXTINF:2637,filename


sleep 10

