#!/bin/bash


## This is a simple bash script that performs the following tasks:
 ## 1. Updates the package lists for apt package manager using the 'apt 
 ## update' command.
 ## 2. Installs the following packages using the 'apt install' command:
 ## - sudo
 ## - curl
 ## - git
 ## - vim
 ## 3. The '-y' option automatically answers yes to any confirmation 
 ## prompts during the installation process, making it non-interactive.
 ## 
 ## In summary, this script ensures that the system is up to date with 
 ## the package lists and then installs the sudo, curl, git, and vim 
 ## packages without user intervention.


apt update
apt install sudo -y
apt install curl -y
apt install git -y
apt install vim -y




