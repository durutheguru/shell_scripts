#!/bin/bash


## This bash script is using the "#!/bin/bash" shebang line to indicate 
 ## that it should be executed using the Bash shell. 
 ## 
 ## The script then runs the "mvn" command with a specific Maven profile 
 ## "-Pnative" and a Maven goal "native:compile". This command will 
 ## execute the "native:compile" goal within the Maven build process, 
 ## which typically means compiling native code for a project.
 ## 
 ## In summary, this script is a simple way to compile native code using 
 ## Maven with a specific profile.


mvn -Pnative native:compile

