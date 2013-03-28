#! /bin/bash
WALLPAPERS="/home/dm/Pictures/Wallpapers/"
ALIST=( `ls -w1 $WALLPAPERS` )
RANGE=${#ALIST[@]}
let "number = $RANDOM"
let LASTNUM="`cat $WALLPAPERS/.last` + $number"
let "number = $LASTNUM % $RANGE"
echo $number > $WALLPAPERS/.last
awsetbg $WALLPAPERS/${ALIST[$number]}

