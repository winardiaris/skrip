#!/bin/bash
# Add Watermark to video
# Requirement
# ffmpeg
# exiftool
# imagemagick

export VideoFile="$1"
export WaterMark="$2"
export Position="$3"

start=$(date +%s.%N)

default_watermark="WATERMARK"

name="`echo $VideoFile | awk -F '.' '{print $1}'`"
extension="`echo $VideoFile | awk -F '.' '{print $2}'`"
video_width=$(exiftool $VideoFile |  grep Image\ Size | awk -F ':' '{print $2}' | sed 's/ //g' | awk -F 'x' '{print $1}')
watermark_width=$(exiftool watermark.png |  grep Image\ Size | awk -F ':' '{print $2}' | sed 's/ //g' | awk -F 'x' '{print $1}')

# position watermark
margin="30"                 # in pixel
center="overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2"
top_left="overlay=$margin:$margin"
top_right="overlay=main_w-overlay_w-$margin:$margin"
bottom_left="overlay=$margin:main_h-overlay_h"
bottom_right="overlay=main_w-overlay_w-$margin:main_h-overlay_h-$margin"

#scaling watermark
limit_scale=35              #in percent of video width
max_watermark=$(echo "$video_width*$limit_scale/100" | bc )


function make_watermark() {
	echo "[Info] Make Watermark file"
  if [ -f ./watermark.png ]; then
    rm -rf watermark.png
  fi

  if [[ -z "${WaterMark// }" ]]; then
    WaterMark=$default_watermark
  fi

  convert -background rgba\(0,0,0,0.3\) -fill rgba\(255,255,255,0.7\) -font open-sans -pointsize 36 -gravity center label:"$WaterMark" watermark.png

}

function scaling_watermark() {

  echo -e "max watermark\t: "$max_watermark
  echo -e "watermark width\t: "$watermark_width
  echo -e "video width\t: "$video_width


  # if [ $watermark_width -gt $max_watermark ]; then
  #   #rezise to max_watermark
  #   convert watermark.png -resize $max_watermark\x$max_watermark watermark2.png
  #   rm -rf watermark.png
  #   mv watermark2.png watermark.png
  # fi
  
    #force rezise to max_watermark
    convert watermark.png -resize $max_watermark\x$max_watermark watermark2.png
    rm -rf watermark.png
    mv watermark2.png watermark.png

}

function add_watermark_to_video() {
	echo "[Info] Adding watermark to Video: $name"
	if [ -f $name\_watermark\.$extension ]; then
		rm -rf $name\_watermark\.$extension
	fi

  if [[ -z "${Position// }" ]]; then
    position_=$center
  else
      if [ "$Position" == "C" ] || [ "$Position" == "c" ]; then
        position_=$center
      fi
      
      if [ "$Position" == "TR" ] || [ "$Position" == "tr" ]; then
        position_=$top_right
      fi

      if [ "$Position" == "TL" ] || [ "$Position" == "tl" ]; then
        position_=$top_left
      fi
      
      if [ "$Position" == "BR" ] || [ "$Position" == "br" ]; then
        position_=$bottom_right
      fi

      if [ "$Position" == "BL" ] || [ "$Position" == "bl" ]; then
        position_=$bottom_left
      fi

  fi

  
  ffmpeg -i $VideoFile -i watermark.png -filter_complex "$position_" -codec:a copy $name\_watermark\.$extension
	
	echo "[Info] Adding watermake has been finished with name: $name _watermark.$extension"
}

make_watermark
scaling_watermark
add_watermark_to_video


dur=$(echo "$(date +%s.%N) - $start" | bc)
echo -e "\n[FINISH] Execution time: $dur "
