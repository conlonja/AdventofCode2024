#!/usr/bin/bash

declare -a tmp1
declare -a tmp2 

# 
IFS=$'\n'
# get the first column and sort it
tmp1=($(awk '{print $1}' input.txt | sort)) 
echo "col1 size = ${#tmp1[@]}"

# get the second column and sort it
echo "====================================================================="
tmp2=($(awk '{print $2}' input.txt | sort))
echo "col2 size = ${#tmp2[@]}"

# output the 
declare -i sum;
echo "" > sortedInput.txt

# cycle through the arrays

for (( index = 0 ; index < ${#tmp1[@]}; index++ )) ; do
	col1=${tmp1[$index]}
	col2=${tmp2[$index]}

	echo "col2 = ${col2}"
	echo "col1 = ${col1}"
        
	echo "${col1}    ${col2}" >> sortedInput.txt

	diff=$((${col2}-${col1}));
	
	if [[ ${diff} -lt 0 ]]; then
		diff=$(( ${diff} * -1 ));
	fi

        echo "diff = ${diff}"

	sum+=${diff};

	echo "running count ${index}=${sum}"
done
