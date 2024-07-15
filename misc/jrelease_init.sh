#! /bin/bash


## This bash script utilizes Docker to run a container using the 
 ## `jreleaser/jreleaser-alpine:latest` image. The script mounts the 
 ## current directory as `/workspace` in the container using the `-v` 
 ## flag. Inside the container, the `init` command is executed with the 
 ## `--format yml` option, which initializes a new JReleaser project in 
 ## the YAML format.
 ## 
 ## In summary, this script sets up and initializes a JReleaser project 
 ## inside a Docker container using the latest version of the 
 ## `jreleaser/jreleaser-alpine` image.

docker run -it --rm -v `(pwd)`:/workspace jreleaser/jreleaser-alpine:latest init --format yml

