#!/bin/bash
export DIRSUMBER="$1"
export DIRTUJUAN="$2"
ARR_FILETYPE=()
ARR_LASTUPDATEYEAR=()
start=$(date +%s.%N)

#buat directory tujuan
mkdir -p $DIRTUJUAN

DATA="$DIRTUJUAN/data.csv"
if [ -f "$DATA" ]
then
	echo "$DATA found."
else
	echo "author,category,directory,file_name,file_size,file_type,last_update,last_update_year,tags" > $DATA
fi


echo -e "\n====[RENAME FILE]================================"
./rename_space.sh $DIRSUMBER



echo "====[COPIYING FILE]=============================="
  # Buat bikin array doang
  for BERKAS in $(find $DIRSUMBER -type f);
  do
    # Mulai Skrip
    AUTHOR="`stat -c %U $BERKAS`"
    FILENAME="`basename $BERKAS`"
    FILESIZE="`du -b $BERKAS | awk '{print $1}'`"
    FILETYPE="${BERKAS##*.}"
    LASTUPDATE="`stat -c %y $BERKAS | awk '{print $1}'`"
    LASTUPDATEYEAR="`stat -c %y $BERKAS | awk '{print $1}' | awk -F'-' '{print $1}'|  sort -u`"
    CATEGORY=""
    TAGS=""
    # ARR_FILETYPE+=("$FILETYPE")
    # ARR_LASTUPDATEYEAR+=("$LASTUPDATEYEAR")

    DIRECTORY="$DIRTUJUAN/$LASTUPDATEYEAR/$FILETYPE"
    mkdir -p $DIRECTORY
    cp -u -v $BERKAS $DIRECTORY


    #buat data indexing
    echo \"$AUTHOR\",\"$CATEGORY\",\"$DIRECTORY\",\"$FILENAME\",\"$FILESIZE\",\"$FILETYPE\",$LASTUPDATE,$LASTUPDATEYEAR,\"$TAGS\" >> $DATA
  done

dur=$(echo "$(date +%s.%N) - $start" | bc)
echo -e "\n====[FINISH] Execution time: $dur =========="
# echo "================================================="

# # printf ${#ARR_FILETYPE[@]} #banyak array
# # printf '%s\n' "${ARR_FILETYPE[@]}"|sort -u # remove duplicate array

# skema
# - renaming space - OK
# - cek LASTUPDATEYEAR - OK
# - cek FILETYPE - OK
# - buat berkas indexing (category,tags)
# - sebelum salin cek dulu category sama? atau tidak? kalau sama
# - salin ke DIRTUJUAN berdasarkan LASTUPDATEYEAR dan FILETYPE - OK
