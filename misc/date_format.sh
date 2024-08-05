#!/bin/bash


if [ $# -eq 0 ]; then
    read -p "Enter epoch milli: " epoch_milli
    read -p "Enter format: " format
elif [ $# -eq 1 ]; then 
    # Assigning input arguments to variables
    epoch_milli=$1
    format="%Y-%B-%d %H:%M:%S"
elif [ $# -ge 2 ]; then 
    # Assigning input arguments to variables
    epoch_milli=$1
    format=$2
fi


if [ -z "$format" ]; then
    format="%Y-%B-%d %H:%M:%S"
fi


date -r $(echo "${epoch_milli} / 1000" | bc) +"${format}"

