#! /bin/bash


## This bash script prompts the user to enter certain parameters related 
 ## to creating a Kafka topic. The user is asked to provide the Bootstrap 
 ## Servers (comma-separated), the number of Partitions, the Replication 
 ## Factor, and the Topic Name.
 ## 
 ## After capturing these inputs, the script then uses the 
 ## `kafka-topics.sh` command to create a new Kafka topic with the 
 ## specified parameters. The `--create` flag is used to signal the 
 ## creation of a new topic, and the provided user inputs are used to 
 ## define the topic's configuration - including the topic name, 
 ## bootstrap servers, replication factor, and number of partitions.
 ## 
 ## In summary, this script facilitates the creation of a Kafka topic by 
 ## interacting with the user to gather the necessary information and 
 ## then using the `kafka-topics.sh` command to execute the topic 
 ## creation process based on the provided parameters.

read -p "Enter Bootstrap Servers (comma separated): " bootstrap_servers
read -p "Enter Partitions: " partitions
read -p "Enter Replication Factor: " replication_factor
read -p "Enter Topic Name: " topic_name

kafka-topics.sh --create --topic $topic_name --bootstrap-server $bootstrap_servers --replication-factor $replication_factor --partitions $partitions

