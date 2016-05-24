#!/bin/bash
export SUMBER="$1"
# cd $SUMBER

function ren(){

  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")
    for FILE in $(find . -type f | grep ' ');
    do
        mv -v "$FILE" `echo $FILE | tr ' ' '_' `
    done
    for FILE in $(find . -type f | grep '[A-Z]');
    do
        mv -v "$FILE" `echo $FILE | tr '[A-Z]' '[a-z]' `
    done
  IFS=$SAVEIFS
}
function rendir(){

  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")
    for FILE in $(find . -type d | grep ' ');
    do
        mv -v "$FILE" `echo $FILE | tr ' ' '_' `
    done

    for FILE in $(find . -type d | grep '[A-Z]');
    do
        mv -v "$FILE" `echo $FILE | tr '[A-Z]' '[a-z]' `
    done
  IFS=$SAVEIFS
}

echo "active dir: "$SUMBER && rendir && ren;
