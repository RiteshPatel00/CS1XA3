# CS 1XA3 Project01 - <pater16>
## Usage
Execute this script from project root with:
chmod +x CS1XA3/Project01/project_analyze.sh
./CS1XA3/Project01/project_analyze arg1 arg2 ...
With possible arguments
arg1: fileType
arg1: findTag
arg1: fixme

## Feature 01 Script Input (6.1)
Description: This feature allows the script to be interactive it gives the user the option to enter in arguements and depending on the arguements it will give either a prompt or preform an action

Execution: execute this feature by giving the project_analyze an argument

## Feature 02 FIXME Log (6.2)
Description: This feature executes with the `fixme` argument and it allows the script to find every file with the word #FIXME in the last line and will create a fixme.log file with the name of the files inside of them

Here is some of the code:
```
    elif [ "$1" == "fixme" ] ; then
         > fixme.log
        for i in `find ./ -type f`; do
    	if [[ -n `tail -1 $i | grep "#FIXME"` ]]; then
    		path="$i"
    		echo $(basename "$path") >> fixme.log
    	fi
    	done
```
`find ./ -type f` is a command that lists out all the files with their paths from the current directory and all the subdirectories. Then we want to for loop through the files and want to use the `tail -1` command to take in the last line of the file and use `grep` to see if that line contains a `#FIXME`. If it does I append the file path name to `fixme.log` 

Execution: execute this feature `./project_analyze fixme`
References:  [[https://osr507doc.xinuos.com/en/OSTut/Reading_just_the_first_or_last_lines_of_a_file.html]]
[[https://stackoverflow.com/questions/10124314/grab-the-filename-in-unix-out-of-full-path]]
[[https://stackoverflow.com/questions/5456120/how-to-only-get-file-name-with-linux-find]]

## Feature 03 File Type Count (6.5)
Description: This feature will execute with the `fileType` argument and it will bring up a prompt asking for a file extension and then proceed to output the number of files in the repo with the given extension

Here is some of the code:
```
    if [ "$1" == "fileType" ] ; then
         
         echo "Enter the file extension: "
         read extension
         echo "Number of $extension files are: "
         find $pwd -type f -name ="*.$extension" | wc -l	
```
The code asks for the file extension and from a command found on stackoverflow that lists all the files with their extensions i.e `find $pwd -type f -name ="*.$extension"` will list the files with the extensions and piping that to a `wc -l` command will count the number of lines. With that the number of files in all subdirectories and the current directory with that file extension will be shown.

Execution: execute this feature `./project_analyze fileType`

References:
[[https://stackoverflow.com/questions/10124314/grab-the-filename-in-unix-out-of-full-path]]
[[https://stackoverflow.com/questions/5456120/how-to-only-get-file-name-with-linux-find]]
[[https://stackoverflow.com/questions/5927369/recursively-look-for-files-with-a-specific-extension]]
## Feature 04 Find Tag (6.6)
Description: This feature will execute with the `findTag` argument and it will bring up a prompt 
asking the user for a tag and save it as a variable

Here is some of the code:
```
    elif [ "$1" == "findTag" ] ; then
         echo "Enter a Tag: "
         read Tag
         > "$Tag.log"
         
         for i in `find $pwd -type f -name "*.py"`; do
           
    	if [[ -n `grep -P '^(?=.*'^#')(?=.*'$Tag')' $i` ]]; then
              path="$i"
              echo $(basename "$path") >> "$Tag.log"
    	fi
         done
```
This code is similar to the File Type feature but here we are only interested in `.py` files so I use the same command for that. Then the specifications ask for lines that contain the `Tag` but those lines must also start with a `#` that's where this command comes into play `grep -P '^(?=.*'^#')(?=.*'$Tag')' $i`. This is a sort of dual grep command that first checks to see if the line starts with `#` and also check if the line contains the `Tag`. If all the requirements are met I make a `$Tag.log` file and append the path name of the files that pass the criteria

Execution: execute this feature `./project_analyze findTag`

References:
[[https://stackoverflow.com/questions/5927369/recursively-look-for-files-with-a-specific-extension]]
[[https://unix.stackexchange.com/questions/55359/how-to-run-grep-with-multiple-and-patterns]]

## Feature 05 Checkout Latest Merge (6.3)
Description: This feature will execute with the `Git` argument and it find the most recent commit with merge in the message and checkout the commit to enter a detached head state

Here is some of the code:
```
elif [ "$1" == "Git" ] ; then
    
    INPUT=`git log --all --grep='merge' -1`
    RESULT=${INPUT:7:40}
    git checkout --detach $RESULT
    
```
This code just `greps` the word `merge` from the commit message. Once I get the commit from the log I split the string to get the commit ID. `${INPUT:7:40}` will extract the commit ID since its offseted by 7 characters and is 40 characters long

Execution: execute this feature `./project_analyze Git`

References:
[[https://stackoverflow.com/questions/44639557/how-can-git-log-all-miss-a-commit-point]]

## Feature 06 File Size List (6.4)
Description: This feature will execute with the `FileSizeList` argument and it will list out all the files in order of size

Here is some of the code:
```
elif [ "$1" == "FileSizeList" ] ; then
    printf "This is ordered by kilobytes\n"
    ls -lR --block-size=KB | grep '^-' | sort -k 5 -rn
    
```
Here I make it quite simple by listing out recursively all files by size. I use a `--block-size=KB` in order to tell the script to show the file sizes in terms of kilobytes but that can be changed based on what the user would want out of the program.

Execution: execute this feature `./project_analyze FileSizeList`

References:
[[https://unix.stackexchange.com/questions/53737/how-to-list-all-files-ordered-by-size]]

## Feature 07 Backup and Delete / Restore (6.8)
Description: This feature will execute with the `Backup/Restore` argument and it will backup all files with the `.tmp` extension

Here is some of the code:
```
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
    
```
I was able to successfully backup all the files and store them in a backup folder with all the file paths in an `restore.log` file however I was unable to restore the files, all that the script does right now is through an error.

Execution: execute this feature `./project_analyze Backup/Restore`

References:
[[https://stackoverflow.com/questions/5927369/recursively-look-for-files-with-a-specific-extension]]


## Custom Feature #1 "Did you put comments?"
Execution: execute this feature `./project_analyze Comments`

Here is some of the code:
```
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
    
```
Description: This feature will prompt the user for a whole number that will represent the minimum number of comments. The script will then take all the python files from the current directory and subdirectories and figure out if the files have comments in it or not, we'll create two files `commentedPythonFiles.txt` and `uncommentedPythonFiles.txt` and append them to the correct file so the user can know which python files need to be commented and which ones have been commented. A comment will be defined with a `#` at the start of the line but along with that the file must have the minimum number of lines that are comments that the user defined in the beginning. If it passes these criterias then it will be appended to the the commented file otherwise it will be known as uncommented

## Custom Feature #2 "Forward or Reverse?"
Execution: execute this feature `./project_analyze Forward/Reverse`

Here is some of the code:
```
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
            
    
```


Description: This feature will prompt the user to either put in `Forward` or `Reverse`. Then it will prompt the user for `alphabetical`, `size`, or `daycreated`. A file named `order(Reverse or Forward)(alphabetical, size or daycreated).log` will be created or overwritten if it already exists, depending on what the user chooses, will determine the file name. If the user choose `Forward` first then `alphabetical` then all the files in the current directory and subdirectories will be appended to the custom file with the names in alphabetical order. Otherwise choosing `Reverse` will be in reverse alphabetical order. `Forward` and `size` will result in all the files being appended from smallest to largest while `Reverse` will indicate sizes from largest to smallest. Finally, `Forward` and `daycreated` will be the files appended from most recently to least recently created and `Reverse` will append files that were created least recently to most recenetly.

UPDATE: The daycreated was unable to be brought to full implementation, unfortunately. The code here would not organize by the day created but rather the most recently modified date. So a file could technically be the first one created but if it is the most recently modified it will be considered the newest out of the bunch.

References:
[[http://man7.org/linux/man-pages/man1/ls.1.html]]

