#! /bin/bash


## This Bash script is taking user input for the Kafka topic and 
 ## bootstrap servers, and then it executes the 
 ## `kafka-console-consumer.sh` command to consume messages from the 
 ## specified Kafka topic. 
 ## 
 ## Here's a breakdown of what each part does:
 ## 1. `#! /bin/bash`: This line is called a shebang and it indicates 
 ## that this script should be executed using the Bash interpreter.
 ## 2. `read -p "Enter Topic Name: " topic_name`: This line prompts the 
 ## user to enter the Kafka topic name and assigns the input to the 
 ## `topic_name` variable.
 ## 3. `read -p "Enter Bootstrap Server(s): " bootstrap_servers`: This 
 ## line prompts the user to enter the Kafka bootstrap server(s) and 
 ## assigns the input to the `bootstrap_servers` variable.
 ## 4. `kafka-console-consumer.sh -bootstrap-server $bootstrap_servers 
 ## --topic $topic_name --from-beginning`: This line executes the 
 ## `kafka-console-consumer.sh` script with the provided bootstrap 
 ## servers and topic name, consuming messages from the beginning of the 
 ## topic.
 ## 
 ## In summary, this script is a simple script that allows users to 
 ## specify a Kafka topic and bootstrap servers and then consumes 
 ## messages from the specified topic using the 
 ## `kafka-console-consumer.sh` command.


read -p "Enter Topic Name: " topic_name
read -p "Enter Bootstrap Server(s): " bootstrap_servers

kafka-console-consumer.sh -bootstrap-server $bootstrap_servers --topic $topic_name --from-beginning
