#! /bin/bash


## This bash script named `find_replace.sh` prompts the user to enter 
 ## three inputs:
 ## 
 ## 1. The file path on which the text replacement should be performed.
 ## 2. The text to be found within the file.
 ## 3. The text that should replace the found text.
 ## 
 ## After receiving these inputs, the script uses `sed` with the `-i` 
 ## option (in-place editing) to find and replace all occurrences of the 
 ## specified text within the file. The `s/$search/$replace/g` command 
 ## within `sed` is used for this purpose.
 ## 
 ## Finally, the script prints out "Done!!!" indicating that the find and 
 ## replace operation has been completed.


read -p "Enter file path: " file
read -p "Enter text to find: " search
read -p "Enter text to replace: " replace


sed -i '' "s/$search/$replace/g" $file
echo "Done!!!"

