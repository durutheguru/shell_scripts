#!/bin/bash


follow_logs() {
    # Get the IDs and names of all running containers
    containers=$(docker ps --format '{{.ID}} {{.Names}}')

    # Loop through each container
    while read -r container_id container_name; do
        # Follow logs for each container in the background
        docker logs -f "$container_id" 2>&1 | awk -v name="$container_name" '{print name " : " $0}' &
    done <<< "$containers"

    # Wait for all background processes to finish
    wait
}


follow_logs


