#! /bin/bash


## This bash script consists of two commands:
 ## 1. `mvn -Pnative`: This command is using Maven to build the project. 
 ## The `-Pnative` option specifies a profile to use during the build 
 ## process. Profiles in Maven are used to customize the build based on 
 ## different environments or requirements.
 ## 2. `spring-boot:build-image`: This is a Maven goal that is part of 
 ## the Spring Boot Maven plugin. It is being used to build a container 
 ## image for the Spring Boot application. This goal packages the 
 ## application as a Docker image, suitable for running in a 
 ## containerized environment.
 ## 
 ## In summary, this bash script is invoking Maven to build a native 
 ## image of a Spring Boot application using the specified profile and 
 ## then packaging it as a container image.

mvn -Pnative spring-boot:build-image
