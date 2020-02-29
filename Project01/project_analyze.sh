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

elif [ "$1" == "FileSizeList" ] ; then
    printf "This is ordered by kilobytes\n"
    ls -lR --block-size=KB | grep '^-' | sort -k 5 -rn



elif [ "$1" == "Git" ] ; then
    
    INPUT=`git log --all --grep='merge' -1`
    RESULT=${INPUT:7:40}
    git checkout --detach $RESULT


elif [ "$1" == "Backup/Restore" ] ; then
    
     echo "Enter in Backup or Restore "
     read result
     
     if [ "$result" == "Backup" ] ; then
        
        if [ -d "backup" ] ; then
            rm -r backup
        fi  

        mkdir backup
        touch restore.log
        for i in `find $pwd -type f -name "*.tmp"`; do
            cp $i ./backup
            rm $i
            echo $i >> "restore.log"
        done
        cp "restore.log" ./backup
        rm "restore.log"



     elif [ "$result" == "Restore" ] ; then     
        echo "Error"
     fi 




elif [ "$1" == "Comments" ] ; then
  echo "Enter in the minumum number of comments "
  read number
  > commentedPythonFiles.txt
  > uncommentedPythonFiles.txt

  for i in `find $pwd -type f -name "*.py"`; do
    counter=`grep -P '^(?=.*'^#')' $i | wc -l`

    if [ "$counter" -ge "$number" ] ; then
        echo $i >> "commentedPythonFiles.txt"

    elif [ "$counter" -lt "$number" ] ; then
        echo $i >> "uncommentedPythonFiles.txt"

    fi
 done

elif [ "$1" == "Forward/Reverse" ] ; then
  echo "Enter in Forward or Reverse "
  read result

  echo "Enter in Alphabet, Size or Time "
  read type
  > "order$result$type.log"


  if [ "$result" == "Forward" ] ; then
      
      if [ "$type" == "Alphabet" ] ; then
             for i in `find . -type f -print0 | xargs -0 ls -dd`; do
                echo $i >> "order$result$type.log"
             done
            

      elif [ "$type" == "Size" ] ; then
            for i in `find . -type f -print0 | xargs -0 ls -dSr`; do
                echo $i >> "order$result$type.log"

             done



      elif [ "$type" == "Time" ] ; then
            for i in `find . -type f -print0 | xargs -0 ls -dt`; do
                echo $i >> "order$result$type.log"
             done
            



        fi
        


  elif [ "$result" == "Reverse" ] ; then  
      
      if [ "$type" == "Alphabet" ] ; then
            for i in `find . -type f -print0 | xargs -0 ls -ddr`; do
                echo $i >> "order$result$type.log"
             done
            



      elif [ "$type" == "Size" ] ; then
            for i in `find . -type f -print0 | xargs -0 ls -dS`; do
                echo $i >> "order$result$type.log"
             done
            




      elif [ "$type" == "Time" ] ; then
            for i in `find . -type f -print0 | xargs -0 ls -dtr`; do
                echo $i >> "order$result$type.log"
             done



    
     fi
  fi  
    
    

fi   

