#!/bin/bash


## This bash script is using Docker to run a container of Kibana, a 
 ## popular open-source analytics and visualization platform designed to 
 ## work with Elasticsearch. There are two commands being executed:
 ## 
 ## 1. The first command creates a Docker container named "kibana" and 
 ## connects it to a Docker network named "elastic". It maps port 5601 on 
 ## the host machine to port 5601 on the Kibana container. It pulls and 
 ## runs the image "docker.elastic.co/kibana/kibana:8.10.4-arm64" which 
 ## specifies the specific version (8.10.4) and architecture (arm64) of 
 ## the Kibana image to use.
 ## 
 ## 2. The second command also creates a Docker container named "kibana" 
 ## and maps port 5601 on the host machine to port 5601 on the Kibana 
 ## container. It runs the same image 
 ## "docker.elastic.co/kibana/kibana:8.10.4-arm64". However, this command 
 ## does not connect the container to any specific network.
 ## 
 ## In summary, both commands launch a Kibana container using the 
 ## specified Docker image, but the first command connects the container 
 ## to a specific Docker network ("elastic") while the second command 
 ## does not.

docker run --name kibana --net elastic -p 5601:5601 docker.elastic.co/kibana/kibana:8.10.4-arm64


docker run --name kibana -p 5601:5601 docker.elastic.co/kibana/kibana:8.10.4-arm64
