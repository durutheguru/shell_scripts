#!/bin/bash



epoch_milli=$(($(date +%s) * 1000))

if [ $# -eq 0 ]; then
    read -p "Enter format: " format
elif [ $# -ge 1 ]; then 
    format=$1
fi


if [ -z "$format" ]; then
    format="%Y-%B-%d %H:%M:%S"
fi


date -r $(echo "$epoch_milli / 1000" | bc) +"$format"
