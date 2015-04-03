#!/bin/bash
echo "actions | apps | categories | devices | emblems  "
echo "extras  | io   | mimetypes  | places  | status  |  stock    "

echo -n "Masukan Nama Folder [ENTER]: "
read icon	

#icon='places'
jumlah=0
pwd=$('pwd')
cd ${icon}/
cd scalable/
mkdir symlink
find . -maxdepth 1 -type l -exec mv {} symlink/ \;
loc=$(pwd)
echo $loc
for x in 0 1 2 3 4 5 6
do
  SAVEIF=$IFS
  IFS=$(echo -en "\n\b")
  for file in $(ls *svg)
  do
    name=${file%%.svg}
   svgcleaner-cli $name.svg $name.svg --remove-prolog --remove-comments  --remove-proc-instr --remove-unused-defs --remove-nonsvg-elts --remove-metadata-elts --remove-inkscape-elts --remove-sodipodi-elts --remove-ai-elts --remove-corel-elts  --remove-msvisio-elts --remove-sketch-elts  --remove-invisible-elts --remove-empty-containers --remove-duplicated-defs --remove-outside-elts  --equal-elts-to-use --ungroup-containers --merge-gradients  --remove-version --remove-unreferenced-ids --remove-notappl-atts 

    jumlah=$((jumlah+1))
  done
done
cd symlink
find . -maxdepth 1 -type l -exec mv {} .. \;
cd ..
rmdir symlink
cd $pwd
echo "Berhasil. $jumlah ikon telah di perkecil."
