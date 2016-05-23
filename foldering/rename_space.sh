#!/bin/bash
export SUMBER="$1"
# cd $SUMBER

function ren(){

  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")
    for FILE in $(find . -type f | grep ' ');
    do
        mv -v "$FILE" `echo $FILE | tr '[:upper:]' '[:lower:]' | tr ' ' '_' `
    done
  IFS=$SAVEIFS
}
function rendir(){

  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")
    for FILE in $(find . -type d | grep ' ');
    do
        mv -v "$FILE" `echo $FILE | tr '[:upper:]' '[:lower:]' | tr ' ' '_' `
    done
  IFS=$SAVEIFS
}


b="`find . -type d | grep ' ' | wc -l`"
 # echo $b
if [[ $b > 0 ]];
then
  echo "active dir: "$SUMBER && rendir;
  c="`find . -type f | grep ' ' | wc -l`"
   # echo $b
  if [[ $c > 0 ]];
  then
    ren;
  else
    echo "no file to rename" ;
  fi
else
  echo "no directory to rename" ;
fi
