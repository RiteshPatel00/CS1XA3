#!/bin/bash




if [ "$1" == "fileType" ] ; then
     
     echo "Enter the file extension: "
     read extension
     echo "Number of $extension files are: "
     find $pwd -type f -name "*.$extension" | wc -l	        


elif [ "$1" == "findTag" ] ; then
     echo "Enter a Tag: "
     read Tag
     > "$Tag.log"
     
     for i in `find $pwd -type f -name "*.py"`; do
       
	if [[ -n `grep -P '^(?=.*'^#')(?=.*'$Tag')' $i` ]]; then
          echo $i >> "$Tag.log"
	fi
     done



elif [ "$1" == "fixme" ] ; then
     > fixme.log
    for i in `find ./ -type f`; do
	if [[ -n `tail -1 $i | grep "#FIXME"` ]]; then
		echo $i >> fixme.log
	fi
	done	
    
    

fi   

