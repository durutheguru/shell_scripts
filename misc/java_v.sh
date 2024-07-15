#!/usr/bin/env bash


## This bash script sets up a Java version using an SDK manager. Here is 
 ## a breakdown of what it does:
 ## 
 ## 1. It sources the `.bash_profile` file. This is typically done to 
 ## load environment variables into the script.
 ## 
 ## 2. It checks the number of arguments passed to the script. If at 
 ## least one argument is provided when running the script, it assigns 
 ## the first argument to the variable `java_version`. Otherwise, it 
 ## prompts the user to enter a Java version.
 ## 
 ## 3. It defines an array `dist_array` containing key-value pairs where 
 ## the key represents a Java version number and the value represents the 
 ## corresponding distribution.
 ## 
 ## 4. It iterates over the elements in the `dist_array` and checks if 
 ## the provided Java version matches any of the keys. If a match is 
 ## found, it assigns the corresponding distribution value to the 
 ## variable `version`.
 ## 
 ## 5. If no matching distribution is found for the provided Java 
 ## version, it prints "Invalid Java Version" and exits the script with 
 ## an exit code of 1.
 ## 
 ## 6. Finally, if a valid Java version and distribution are identified, 
 ## it uses the SDK manager to set up the Java version specified by 
 ## `$version`.
 ## 
 ## Overall, this script allows users to specify a Java version as an 
 ## argument or interactively, maps the version to the corresponding 
 ## distribution, and sets up the specified Java version using an SDK 
 ## manager. It provides feedback in case of an invalid Java version 
 ## input.


source ~/.bash_profile


if [ $# -ge 1 ];
then
   java_version=${1}
else 
   read -p "Enter Java Version: " java_version
fi


dist_array=("8:8.0.352-zulu" "11:11.0.18-amzn" "17:17.0.5-zulu" "19:19.0.2-oracle" "22:22.3.r19-grl")

for element in "${dist_array[@]}"; do
  key=${element%%:*}
  value=${element#*:}
  if [ $key == $java_version ]; then
    version=$value
  fi
done

if [ -z "$version" ]; then
  echo "Invalid Java Version"
  exit 1
fi

sdk use java $version


