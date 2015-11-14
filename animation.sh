#!/bin/bash

declare -i count
count=1
pathfile=$1
point=$(cat $pathfile)
for i in "$(cat $1)";
do
	openscad Persona-FW-Kin.scad -o frame"$count".png  -D pos=$i --render --imgsize=300,200 
	count=$count+1
	echo $i
	echo $count
done


