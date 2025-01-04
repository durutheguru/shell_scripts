#!/bin/bash

echo "Run Consul"
echo "====================================================="
echo "Consul Agent Options"
echo ""
echo "1) Simple Server"
echo "2) Development Mode"
echo "3) Embedded Agent (insecure)"
echo "4) Embedded Agent (secure)"
echo "5) Config File with Cluster and Join"
echo "6) Config File with Cluster, Join, and Leave"
echo "7) Config File with Cluster and Split-Brain Protection"
echo "8) Consul Server (no client services)"
echo "9) Consul Agent (no server or client services)"
echo "10) Development Mode with Raft Leader Election"
read -p "Enter your choice: " opt

case $opt in
    1)
        file_name="simple-server.json"
        ;;
    2)
        file_name="dev-mode.json"
        ;;
    3)
        file_name="embedded-agent-insecure.json"
        ;;
    4)
        file_name="embedded-agent-secure.json"
        ;;
    5)
        file_name="config-with-cluster-and-join.json"
        ;;
    6)
        file_name="config-with-cluster-join-and-leave.json"
        ;;
    7)
        file_name="config-with-cluster-split-brain-protection.json"
        ;;
    8)
        file_name="consul-server-no-client-services.json"
        ;;
    9)
        file_name="consul-agent-no-server-or-client-services.json"
        ;;
    10)
        file_name="dev-mode-with-raft-leader-election.json"
        ;;
esac

OUTPUT_FILE=/tmp/$file_name

addr_ip=$(ipconfig getifaddr en0)

sed "s/<<addr_ip>>/$addr_ip/g" "$file_name" > "$OUTPUT_FILE"

consul agent -config-file=$OUTPUT_FILE

