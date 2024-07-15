
#!/bin/bash

pwd

git status

read -p "Do you wish to add the files? (y/n) " proceed

[ $proceed == "n" ] && exit 1 || git add .


echo "Type Commit Message. Ctrl+D to save... "

msg=$(cat)

read -p "Do you wish to Commit changes? (y/n) " proceed


[ $proceed == "n" ] && exit 1 || git commit -m "$msg"


echo "Done!!"


