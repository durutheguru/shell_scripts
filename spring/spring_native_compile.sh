#!/bin/bash


## This is a simple Bash script that consists of two commands. 
 ## 
 ## 1. The `#!/bin/bash` shebang line at the beginning indicates that 
 ## this script should be interpreted and executed by the Bash shell.
 ## 
 ## 2. The `mvn` command is being used to run a specific Maven goal. Here 
 ## is the breakdown of the command options:
 ## - `-Pnative`: This option activates the Maven profile named 
 ## "native", which could be a profile configured with specific settings 
 ## for building a native executable using tools like GraalVM.
 ## - `-DskipTests`: This option sets a system property "skipTests" to 
 ## skip running any tests during the build process.
 ## - `native:compile`: This is the Maven goal that is being executed, 
 ## specifically instructing Maven to compile the native code.
 ## 
 ## In summary, this script is invoking Maven with specific options and 
 ## goals to compile native code without running any tests.

mvn -Pnative -DskipTests native:compile

