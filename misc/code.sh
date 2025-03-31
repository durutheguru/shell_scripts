#!/bin/bash

if [ -z "$1" ]; then
  open -a "Visual Studio Code"
else
  open -a "Visual Studio Code" "$1"
fi

