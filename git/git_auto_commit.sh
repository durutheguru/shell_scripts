#!/bin/bash 


## This bash script performs the following tasks:
 ## 
 ## 1. It initializes an empty array named "files".
 ## 2. It loops over the output of the "git status --porcelain" command 
 ## line by line.
 ## 3. For each line, it extracts the status (M, A, D, or ??) and the 
 ## corresponding file.
 ## 4. If the status is M, A, D, or ??, it appends the status and file to 
 ## the "files" array.
 ## 5. After processing all lines from the "git status --porcelain" 
 ## output, it checks if there are any files in the "files" array.
 ## 6. If there are files to commit, it creates a commit message 
 ## containing the status and the file names.
 ## 7. It then uses "git commit -am" to commit the changes with the 
 ## generated commit message.
 ## 8. If there are no files in the "files" array, it outputs "No changes 
 ## to commit."
 ## 
 ## In summary, the script reads the output of "git status --porcelain" 
 ## to identify modified, added, or deleted files and then automatically 
 ## commits these changes with the appropriate status and file names as 
 ## part of the commit message. If there are no changes to commit, it 
 ## notifies the user.


files=()

while IFS= read -r line; do
  status=$(echo "$line" | awk '{print $1}')
  file=$(echo "$line" | awk '{print $2}')
  
  if [[ $status =~ ^(M|A|D|\?\?)$ ]]; then
    files+=("$status: $file")
  fi
done < <(git status --porcelain)

# Commit the changes
if [[ ${#files[@]} -gt 0 ]]; then
  commit_message=$(printf "%s\n" "${files[@]}")
  git commit -am "$commit_message"
else
  echo "No changes to commit."
fi

