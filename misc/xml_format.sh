#! /bin/bash


## This bash script prompts the user to enter raw XML data. Once the 
 ## user finishes entering the XML data and presses Ctrl+D, the script 
 ## reads and captures the entered XML data into a variable called 
 ## `data`. 
 ## 
 ## After capturing the input, the script prints two new lines for 
 ## formatting and then echoes the captured XML data to `xmllint` with 
 ## the `--format` flag. The `xmllint` command is used for formatting XML 
 ## data in a readable way. 
 ## 
 ## In summary, this script takes input of raw XML data from the user, 
 ## formats it using `xmllint`, and then displays the formatted XML 
 ## output.

echo "Enter Raw XML. Ctrl+D to exit... "

data=$(cat)
printf "\n\n"
echo "$data" | xmllint --format -

