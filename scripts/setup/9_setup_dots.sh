#!/bin/bash

##
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTS_DIR="dots"
##
DOTS_DIR="$SCRIPT_DIR/../../$DOTS_DIR"
##
cd $DOTS_DIR

# Function to sym link
sym_link(){
	file=$1
	d_file=$2
	if [[ -z "$2" ]]; then
		return 
	fi
	echo "-> $d_file"
	if [[ -e $d_file ]]; 
	then
		if [[ -L $d_file || -h $d_file ]];
		then
			echo "  [Skip] $d_file, symbolic link already exist"
			return 
		else
			sufix="_bak"
			d_file_bak="$d_file$sufix"
			echo "  [Backup] $d_file to $d_file_bak"
			mv $d_file $d_file_bak
		fi
	fi
	echo "  [Created] $d_file "
	ln -s $file $d_file
}

## symbolic links to config
if  [ -d ".config" ] ;
then
	cd .config
	for file in *; do
		#echo "sym $file"
		sym_link "$(pwd)/$file" "$HOME/.config/$file" "$HOME/.config/"
		# if [ -e $d_file ]; 
		# then
		# 	if [ -L $d_file ];
		# 	then
		# 		echo "Skip $d_file, symbolic link already exist"
		# 	else
		# 		sufix="_bak"
		# 		$d_file_bak="$d_file$sufix"
		# 		echo "Backup $d_file to $d_file_bak"
		# 		mv $d_file $d_file_bak
		# 		echo "create symbolic link to $d_file "
		# 	fi
		# else
		# 	echo "create symbolic link to $d_file "
		# 	#ln -s "$(pwd)/$file" ~/.config/
		# fi
	done
	cd ..
fi

# for file in $(find . -maxdepth 1 -not -path ".config" ); do
# 	echo "-> $file"
# 	#sym_link   "$(pwd)/$file" "$HOME/$file"
# done
for file in $(ls -a); do
	if [[ "$file" ==   "."  || "$file" == ".." || "$file" == ".config" ]]; then
		continue
	fi
	sym_link   "$(pwd)/$file" "$HOME/$file"
done

