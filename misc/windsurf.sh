#!/bin/bash 


if [ -z "$1" ]; then
  open -a Windsurf
else
  open -a Windsurf "$1"
fi

