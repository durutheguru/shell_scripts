#!/bin/bash


## This bash script is used to set up a Docker network for hosting 
 ## Elasticsearch containers. Here is a breakdown of what each section of 
 ## the script does:
 ## 
 ## 1. `docker network create elastic`: This command creates a Docker 
 ## network named "elastic" that will be used to connect the 
 ## Elasticsearch containers.
 ## 
 ## 2. `docker run --name elasticsearch --net elastic -p 9200:9200 -p 
 ## 9300:9300 -e "discovery.type=single-node" -t 
 ## docker.elastic.co/elasticsearch/elasticsearch:8.10.3-arm64`: This 
 ## command runs an Elasticsearch container named "elasticsearch" within 
 ## the "elastic" network. It maps the container's ports 9200 and 9300 to 
 ## the same ports on the host machine, sets the environment variable 
 ## `discovery.type` to "single-node" indicating that only one node is 
 ## expected, and uses the Elasticsearch image 
 ## `docker.elastic.co/elasticsearch/elasticsearch:8.10.3-arm64`.
 ## 
 ## 3. `docker run --name es01 --net elastic -p 9200:9200 -it -m 1GB 
 ## docker.elastic.co/elasticsearch/elasticsearch:8.10.3-arm64`: This 
 ## command runs another Elasticsearch container named "es01" within the 
 ## "elastic" network. It maps the container's port 9200 to the host 
 ## machine, allocates a maximum of 1 GB of memory for the container, and 
 ## uses the same Elasticsearch image as the previous container.
 ## 
 ## Overall, this script sets up an environment to run two Elasticsearch 
 ## containers connected to a shared Docker network. The first container 
 ## is configured as a single-node Elasticsearch instance, while the 
 ## second container is set up with resource limits and a name "es01". 
 ## The containers are based on the Elasticsearch image version 8.10.3 
 ## for ARM64 architecture.


docker network create elastic
docker run --name elasticsearch --net elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -t docker.elastic.co/elasticsearch/elasticsearch:8.10.3-arm64

docker run --name es01 --net elastic -p 9200:9200 -it -m 1GB docker.elastic.co/elasticsearch/elasticsearch:8.10.3-arm64
