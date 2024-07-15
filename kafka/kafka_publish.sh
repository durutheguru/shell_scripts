#!/bin/bash


## ### Description of the Bash script:
 ## 
 ## 1. **Topic and Broker Configuration:**
 ## - The script sets the Kafka topic name to `<<topic_name>>` and the 
 ## broker URL to `localhost:9093`.
 ## 
 ## 2. **JSON Message Creation:**
 ## - A JSON message is created and stored in the `msg` variable. The 
 ## message includes fields such as reference, account numbers, currency 
 ## code, transaction amount, triggers with reasons, and actions.
 ## 
 ## 3. **For Loop for Sending Message:**
 ## - The script contains a `for` loop that runs one iteration (i.e., 
 ## sending the message once).
 ## 
 ## 4. **Sending Message to Kafka Topic:**
 ## - Within the loop, it uses the `kafka-console-producer.sh` script 
 ## to send the JSON message to the Kafka topic specified by the 
 ## `$topic_name` variable and the broker URL specified by the 
 ## `$broker_url` variable.
 ## 
 ## 5. **Additional Configuration (Commented Out):**
 ## - There is a commented line (`#`) for an alternative way to run 
 ## the Kafka producer using a configuration file 
 ## (`settings.properties`), but it is currently not utilized in the 
 ## script.
 ## 
 ## ### Overall Purpose:
 ## - **Purpose:** This script serves as a simple Kafka producer script 
 ## that sends a predefined JSON message to a Kafka topic.
 ## - **Functionality:** It facilitates testing or demonstration by 
 ## allowing the quick production of a sample JSON message to a Kafka 
 ## topic.
 ## 
 ## ### Note:
 ## - You can customize the topic name, broker URL, and the JSON message 
 ## to suit your specific scenario or requirements.


topic_name="<<topic_name>>"
broker_url="localhost:9093"
msg='{"reference":"PERF_TEST_2|8809082910|163637811199118836471109_DEBIT_0","ledgerAccountNumber":"0000225600","nubanAccountNumber":"8000035587","currencyCode":"566","transactionAmount":2000,"triggers":[{"reason":"broke the first rule","action":["LIEN"]},{"reason":"broke the second rule","action":["PND"]}]}'

for ((i=1; i<=1; i++)); do
  echo "$msg" | kafka-console-producer.sh --broker-list $broker_url --topic $topic_name
#   echo "$current_msg" | kafka-console-producer.sh --broker-list $broker_url --topic $topic_name --producer.config settings.properties
done

