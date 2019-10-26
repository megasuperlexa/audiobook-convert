#!/bin/bash

# variables
i=0
green='\033[0;32m'
reset='\033[0m'
output_file="output/output.mp3"

mkdir -p input
mkdir -p output

# flatten folders if any
parent=./input
newfolder=./input
for folder in "$parent"/*; do
  if [[ -d "$folder" ]]; then
    foldername="${folder##*/}"
    for file in "$parent"/"$foldername"/*; do
      filename="${file##*/}"
      newfilename="$foldername"_"$filename"
      mv "$file" "$newfolder"/"$newfilename"
    done
  fi
done

echo -e "${green}Combining the following audiobook parts: ${reset}"
for audiobook in input/*.mp3; do
	# get audiobook name without the input prefix
	name="${audiobook#"input/"}"

	# get the filename without the extension
	filename="${name%.*}"

	# concat parts file into a single string for
	if [[ $i < 1 ]]; then
		parts="${audiobook}"
	else
		parts="$parts|${audiobook}"
	fi

	echo -e "${name}"
	(( i++ ))
done

echo -e "${green}Ready to combine and convert to m4b (y/n)? ${reset}"
read response
if echo -e "$response" | grep -iq "^y" ;
then
	echo "${green}Combining audiobook parts... ${reset}"
	ffmpeg -i concat:"${parts}" -acodec copy output/output0.mp3
	for cover in input/*.png 
	do
        if [ -f "$cover" ] 
        then
            ffmpeg -i output/output0.mp3 -i "${cover}" -map 0:0 -map 1:0 -c copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" output/output.mp3
        else
            mv output/output0.mp3 output/output.mp3
        fi
    done

	if [ -f "$output_file" ]
	then
		echo -e "${green}Converting mp3 to m4a... ${reset}"
		ffmpeg -i "${output_file}" -c:a libfdk_aac -c:v copy "output/${filename}-converted.m4a"
		if [[ -f "output/${filename}-converted.m4a" ]]; then
			echo -e "${green}Renaming .m4a to .m4b... ${reset}"
			rm -rf ${output_file}
			rm -rf output/output0.mp3
			cd output/ && rename m4a m4b *
			mp4file --optimize *.m4b
			echo "done"
		fi
	fi
fi
