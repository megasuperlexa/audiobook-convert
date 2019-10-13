#!/bin/bash

# variables
i=0
green='\033[0;32m'
reset='\033[0m'
output_file="output/output.mp3"

mkdir -p input
mkdir -p output

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
	ffmpeg -i concat:"${parts}" -acodec copy output/output.mp3

	if [ -f "$output_file" ]
	then
		echo -e "${green}Converting mp3 to m4a... ${reset}"
		ffmpeg -i "${output_file}" -c:a libfdk_aac -c:v copy "output/${filename}-converted.m4a"
		if [[ -f "output/${filename}-converted.m4a" ]]; then
			echo -e "${green}Renaming .m4a to .m4b... ${reset}"
			rm -rf ${output_file}
			cd output/ && rename m4a m4b *
			mp4file --optimize *.m4b
			echo "done"
		fi
	fi
fi