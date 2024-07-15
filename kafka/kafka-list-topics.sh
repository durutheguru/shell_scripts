#! /bin/bash


## This Bash script executes the command `kafka-topics.sh` with the 
 ## options `--bootstrap-server localhost:9092 --list`. 
 ## 
 ## The command `kafka-topics.sh` is a Kafka tool used to interact with 
 ## Kafka topics. With the `--bootstrap-server` option, it specifies the 
 ## Kafka broker to connect to for retrieving metadata. In this case, it 
 ## connects to `localhost:9092`. The `--list` option instructs the tool 
 ## to list all the topics available on the Kafka cluster. 
 ## 
 ## Therefore, the script, when run, will list all the topics available 
 ## on the Kafka cluster hosted at `localhost:9092`.

kafka-topics.sh --bootstrap-server localhost:9092  --list


