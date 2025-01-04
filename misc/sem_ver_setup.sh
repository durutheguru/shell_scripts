#! /bin/bash


## This bash script is designed to set up a project to use Git Flow 
 ## Semantic Versioning. Here's a breakdown of what each line does:
 ## 
 ## 1. `#! /bin/bash`: This line specifies that the script should be 
 ## interpreted using the Bash shell.
 ## 
 ## 2. `git fetch origin master`: This line fetches the latest changes 
 ## from the remote `master` branch.
 ## 
 ## 3. `git fetch origin develop`: This line fetches the latest changes 
 ## from the remote `develop` branch.
 ## 
 ## 4. `git flow init`: This line initializes Git Flow, a branching model 
 ## for Git. It creates the necessary branches (e.g., `develop` and 
 ## `feature/`) and defines the rules for branch naming and merging.
 ## 
 ## 5. `gitversion init`: This line initializes GitVersion, a tool for 
 ## managing versioning within a Git repository. It likely sets up the 
 ## project to follow semantic versioning guidelines.
 ## 
 ## 6. `git push -u origin master`: This line pushes the local `master` 
 ## branch to the remote repository and sets it as the upstream branch.
 ## 
 ## 7. `git push -u origin develop`: This line pushes the local `develop` 
 ## branch to the remote repository and sets it as the upstream branch.
 ## 
 ## Overall, this script automates the setup process required to 
 ## implement Git Flow and Semantic Versioning in a project, ensuring 
 ## consistency and best practices in managing branches and versioning.


git fetch origin main
git fetch origin develop

git flow init
gitversion init

git push -u origin main
git push -u origin develop

