#!/bin/bash

## Prints the first X lines of a file, where X is supplied as an argument


if [ $# == 2 ];
then
  awk "NR<=${2} {print}" "${1}"
else
  read -p "Enter File name: " "file_name"
  read -p "How many lines: " lines
  awk "NR<=$lines {print}" "$file_name"
fi
