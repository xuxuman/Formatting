#!/bin/bash

if [ $# == 2 ]
then
	lengthMax=()
	space=""
	num=0	
	lengthMax=`awk -v lenthMax="$lengthMax[@]" 'BEGIN{
	}{}{
	for(i=1;i<NF;i++){
		if(lengthMax[i]<length($i)){
			lengthMax[i]=length($i) 
		}
	}
	}{if(num<NF){
		num=NF
	}}END{
		for(i=1;i<num;i++){
		printf "%d",lengthMax[i]
		if(i!=(num-1)){
			printf " "
		}
	}
	}' $1`
	bkqIFS="$IFS"
	IFS=' ' read -r -a lengthMax <<< ${lengthMax[@]}
	IFS="$bkqIFS"
	
	awk -v lengthMax="${lengthMax[*]}" 'BEGIN{
		split(lengthMax,lengthMaxs," ")
	}{
	record=""
	for(j=1;j<NF+1;j++){
		space=""
		for(i=0;i<(lengthMaxs[j]-length($(j))+5);i++){
			space=space " "
		}
		record=record $(j) space
	} 
	printf "%s\n",record }' $1 >> $2 
else
	echo "you need to specify the source file and the output file in order"
fi
