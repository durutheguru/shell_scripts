#! /bin/bash


## This bash script is removing multiple directories using the `rm -r` 
 ## command. Here is a breakdown of what each line does:
 ## 
 ## 1. `rm -r dto`: This command removes the "dto" directory and its 
 ## contents recursively.
 ## 2. `rm -r controller`: This command removes the "controller" 
 ## directory and its contents recursively.
 ## 3. `rm -r service`: This command removes the "service" directory and 
 ## its contents recursively.
 ## 4. `rm -r util`: This command removes the "util" directory and its 
 ## contents recursively.
 ## 5. `rm -r entity`: This command removes the "entity" directory and 
 ## its contents recursively.
 ## 6. `rm -r repository`: This command removes the "repository" 
 ## directory and its contents recursively.
 ## 
 ## In summary, the script is deleting multiple directories named "dto", 
 ## "controller", "service", "util", "entity", and "repository" along 
 ## with all their contents in a recursive manner.

rm -r dto
rm -r controller
rm -r service
rm -r util
rm -r entity
rm -r repository

