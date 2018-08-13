#!/bin/sh

clear
COUNT=1
INDEX=1
SUB_IND=0
CONTAINER=$(docker ps --format "{{.Names}}")
for item in $CONTAINER
do
	COUNT_ARR[$SUB_INT]=$item
	let SUB_INT=$SUB_INT+1
done

f1 () 
{
	echo "-----------"
	echo "q - up / w - down / enter or 1-9 - exec to container / any key - exit /"
	echo "-----------"

	echo ""
	for item in $CONTAINER
	do
		if [[ $COUNT == $INDEX ]]
		then
			echo "\033[0;32m"$COUNT $item" \033[0m"
		else
			echo $COUNT $item
		fi
		let COUNT=${COUNT}+1
	done
	wait
}

wait ()
{
	read -n 1 KEYCODE
	if [[ $KEYCODE == "q" ]]
	then
		if [[ $INDEX == 1 ]]
		then
			let INDEX=$COUNT-1; let COUNT=1; clear; f1
		else
			let COUNT=1; let INDEX=$INDEX-1; clear; f1
		fi
	fi
	if [[ $KEYCODE == "w" ]]
	then
		if [[ $INDEX == $(($COUNT-1)) ]]
		then
			let INDEX=1; let COUNT=1; clear; f1
		else
			let COUNT=1; let INDEX=$INDEX+1; clear; f1
		fi
		
	fi

	if [[ $KEYCODE == "1" || $KEYCODE == "2" || $KEYCODE == "3" || $KEYCODE == "4" || $KEYCODE == "5" || $KEYCODE == "6" || $KEYCODE == "7" || $KEYCODE == "8" || $KEYCODE == "9" ]]
	then
		clear
		docker exec -ti ${COUNT_ARR[$(($KEYCODE - 1))]} bash
		echo ${COUNT_ARR[$(($KEYCODE - 1))]}
		exit
	fi
	if [[ $KEYCODE == "" ]]
	then
		clear
		docker exec -ti ${COUNT_ARR[$INDEX-1]} bash
		exit
	fi
}


f1

