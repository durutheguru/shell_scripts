#! /bin/bash


## This bash script allows the user to input Bootstrap Servers 
 ## (comma-separated) and a Topic Name. It then uses the kafka-topics.sh 
 ## script to delete the specified topic name from the given bootstrap 
 ## servers. The kafka-topics.sh script is typically used for managing 
 ## Kafka topics, and in this case, the '--delete' option is used to 
 ## delete the specified topic.


read -p "Enter Bootstrap Servers (comma separated): " bootstrap_servers
read -p "Enter Topic Name: " topic_name


kafka-topics.sh --bootstrap-server $bootstrap_servers --delete --topic $topic_name

