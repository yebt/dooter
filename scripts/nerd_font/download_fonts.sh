#!/bin/bash

## 
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DIR_P="zip"
UNZIP_D="unziped_fonts"
FILE_LINKS="nerd_font_links"

##

python ./get_links.py

##

file="$SCRIPT_DIR/$FILE_LINKS"

# Remove old downloads
DIR_P="$SCRIPT_DIR/$DIR_P"
rm -rf $DIR_P
mkdir $DIR_P
cd $DIR_P

## download zips
while read line; 
do
	axel $line
done < $file

# unzip
UZ_DIR="$SCRIPT_DIR/$UNZIP_D"
rm -rf $UZ_DIR
mkdir $UZ_DIR
unz (){
    [ -z "$1" ] && echo "no file to unzip :|" && exit 1
    name="${1%.*}"
    echo "----------------------"
    echo "uncompress ----------- $1"
    echo "----------------------"
    unzip $1 -d "$UZ_DIR/$name"
}
ls
zips=$(ls *.zip 2> /dev/null)

for f in $zips ; do
    unz $f
done
