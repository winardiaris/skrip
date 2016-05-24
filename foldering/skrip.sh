#!/bin/bash
#HOWTO USE: ./skrip.sh SOURCEDIR DESTDIR ALLOWFILETYPE
#ALLOWFILETYPE : zip,deb,sh,bin

export DIRSUMBER="$1"
export DIRTUJUAN="$2"
export ALLOWFILETYPE="$3"

start=$(date +%s.%N)


function EXEC(){
	mkdir -p $DIRECTORY
	cp -u -v $BERKAS $DIRECTORY
	#masukan data indexing
	echo \"$AUTHOR\",\"$CATEGORY\",\"$DIRECTORY\",\"$FILENAME\",\"$FILESIZE\",\"$FILETYPE\",$LASTUPDATE,$LASTUPDATEYEAR,\"$TAGS\" >> $DATA
}


#buat directory tujuan
mkdir -p $DIRTUJUAN

#buat data indexing
DATA="$DIRTUJUAN/data.csv"
if [ -f "$DATA" ]
then
	echo "$DATA is already exist."
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

    DIRECTORY="$DIRTUJUAN/$LASTUPDATEYEAR/$FILETYPE"

		IFS=',' read -ra ARR_FILETYPE <<< "$ALLOWFILETYPE"
		# ARR_FILETYPE=$ALLOWFILETYPE
		ADA=${#ARR_FILETYPE[@]}

		# echo $ADA

		if [ "$ADA" -gt 0 ]
		then
			# echo "ada file_type dipilih"
			for I in "${ARR_FILETYPE[@]}";
			do
					if [ "$FILETYPE" == "$I" ];
					then
						# echo "extensi sama: "$I
						EXEC
					fi
			done
		else
			# echo "semua file_type dipilih"
			EXEC
		fi

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
