#!/bin/bash

if [ $# == 2 ]
then
	lengthMax=0
	space=""

	lengthMax=`awk -v lengthMax="$lengthMax" 'BEGIN{}{
	if(lengthMax<=length($1)){
	lengthMax=length($1) 
	printf "%d\n",lengthMax
	}
	}{}' $1|tail -n 1`

	lengthMax=`expr $lengthMax + 7`

	awk -v lengthMax="$lengthMax"  'BEGIN{}{}{
	space=""
	for(i=0;i<(lengthMax-length($1));i++){
	space=space " "}
	printf "%s%s%s%s\n",$1,space,$2,$3
	}' $1 >> $2
else
	echo "you need to specify the source file and the output file in order"
fi
