#!/bin/bash
#Height and Width
H=300
W=300
#prefix
PR="resized"
#default dpi is 90
DPI=90
#pt to px
xH=$(((H*72)/DPI));
xW=$(((W*72)/DPI));



function Go {
	a="`date '+%F-%H-%M-%S'`"
	b="$PR-$a"
	mkdir $b
	c=0
	for file in $(ls *svg)
	do
		name=${file%%.svg}
		rsvg-convert $name.svg -o $b/$name.svg -f svg -w $xW -h $xH
		c=$((c+1))
	done
	echo " $c SVG file has been resized."
}
if [ -a "/usr/bin/rsvg-convert" ]; then
	Go
else
	sudo apt-get install  librsvg2-bin
	Go
fi




