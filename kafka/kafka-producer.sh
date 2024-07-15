#! /bin/bash


## This bash script checks the number of arguments passed to the script. 
 ## If the number of arguments is 2, it will use the first argument as 
 ## the broker URL and the second argument as the topic name to pass to 
 ## the Kafka console producer. If the correct number of arguments is not 
 ## provided, it prompts the user to enter the topic name and broker URL 
 ## interactively and then uses those inputs to call the Kafka console 
 ## producer. So, this script acts as a simplified wrapper around the 
 ## Kafka console producer, allowing the user to enter the broker URL and 
 ## topic name either through arguments or interactively.


if [ $# == 2 ];
then
    kafka-console-producer.sh --broker-list ${1} --topic ${2}
else
    read -p "Enter Topic Name: " topic_name
    read -p "Enter Broker URL: " broker_url

    kafka-console-producer.sh --broker-list $broker_url --topic $topic_name
fi




