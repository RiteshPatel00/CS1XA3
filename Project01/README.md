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

## Custom Feature "Did you put comments?"
Description: This feature will prompt the user for a whole number that will represent the minimum number of comments. The script will then take all the python files from the current directory and subdirectories and figure out if the files have comments in it or not, we'll create two files `commentedPythonFiles.txt` and `uncommentedPythonFiles.txt` and append them to the correct file so the user can know which python files need to be commented and which ones have been commented. A comment will be defined with a `#` at the start of the line but along with that the file must have the minimum number of lines that are comments that the user defined in the beginning. If it passes these criterias then it will be appended to the the commented file otherwise it will be known as uncommented

## Custom Feature "Forward or Reverse?"
Description: This feature will prompt the user to either put in `Forward` or `Reverse`. Then it will prompt the user for `alphabetical`, `size`, or `daycreated`. A file named `order(Reverse or Forward)(alphabetical, size or daycreated).log` will be created or overwritten if it already exists, depending on what the user chooses, will determine the file name. If the user choose `Forward` first then `alphabetical` then all the files in the current directory and subdirectories will be appended to the custom file with the names in alphabetical order. Otherwise choosing `Reverse` will be in reverse alphabetical order. `Forward` and `size` will result in all the files being appended from smallest to largest while `Reverse` will indicate sizes from largest to smallest. Finally, `Forward` and `daycreated` will be the files appended from most recently to least recently created and `Reverse` will append files that were created least recently to most recenetly.
