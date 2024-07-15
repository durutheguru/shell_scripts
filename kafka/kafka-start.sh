#! /bin/bash


## This bash script is using the `osascript` command to execute 
 ## AppleScript code in order to interact with the Terminal application 
 ## on macOS. Here's a breakdown of what the script is doing:
 ## 
 ## 1. The first `osascript` block opens a new Terminal window and 
 ## executes two commands in sequence:
 ## - `cd /Users/dduru/Documents/Documents_Dumebi.Duru/Setups/kafka`: 
 ## Changes the current directory to the specified Kafka setup directory.
 ## - `zookeeper-server-start.sh config/zookeeper.properties`: Starts 
 ## the Zookeeper server using the specified configuration file.
 ## 
 ## 2. The second `osascript` block opens another new Terminal window and 
 ## executes two commands in sequence as well:
 ## - `cd /Users/dduru/Documents/Documents_Dumebi.Duru/Setups/kafka`: 
 ## Changes the current directory to the same Kafka setup directory as 
 ## before.
 ## - `kafka-server-start.sh config/server.properties`: Starts the 
 ## Kafka server using the specified server configuration file.
 ## 
 ## In summary, this script automates the process of starting Zookeeper 
 ## and Kafka servers by opening Terminal windows and executing the 
 ## necessary commands to start the servers using specific configuration 
 ## files in the specified directories.

osascript <<END 
tell application "Terminal"
    do script "cd /Users/dduru/Documents/Documents_Dumebi.Duru/Setups/kafka;zookeeper-server-start.sh config/zookeeper.properties"
end tell
END


osascript <<END 
tell application "Terminal"
    do script "cd /Users/dduru/Documents/Documents_Dumebi.Duru/Setups/kafka;kafka-server-start.sh config/server.properties"
end tell
END

