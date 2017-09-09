#!/bin/bash
# how to
# resizeImage 2000 50
export whover="$1"
export resize="$2"

for file in $(ls | grep -E 'jpg|png')
do
  width="`exiftool $file | grep "Image Size" | awk -F ':' '{print $2}' | awk -F 'x' '{print $1}'`"
  height="`exiftool $file | grep "Image Size" | awk -F ':' '{print $2}' | awk -F 'x' '{print $2}'`"

  if [ $width -gt $whover ] || [ $height -gt $whover ];
  then
    mogrify -resize $resize% $file
  fi
done

