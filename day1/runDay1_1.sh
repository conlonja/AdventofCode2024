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

# create the count of each value in the right hand list 
declare -A rightIndex;
declare -i count

set -- "${tmp2[@]}"
while (( $# ))
do
	val=$1
	echo "$((++count))"
	echo "processing $val"
	rightIndex["$val"]=$((${rightIndex[$val]}+1))
	shift
done
# print out for debug
for i in ${!rightIndex[@]}; do
	echo "right index ${i} = ${rightIndex[$i]}"
done

# for each value in left list, multiply by the index value of the right list.

declare -i simIndex
for (( index = 0 ; index < ${#tmp1[@]}; index++ )) ; do
	
	col1=${tmp1[$index]}
	col2Index=${rightIndex[${col1}]}

	[ ${col2Index} ] && echo "col1 = ${col1}, col2Index=${col2Index}" || continue \
		

	simIndex+=$((${col1} * ${col2Index}))

	
	echo "running count ${index}=${simIndex}"
done
