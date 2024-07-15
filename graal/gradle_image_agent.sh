#!/bin/bash


./gradlew -Pagent run # Runs on JVM with native-image-agent.
./gradlew metadataCopy --task run --dir src/main/resources/META-INF/native-image # Copies the metadata collected by the agent into the project sources
./gradlew nativeCompile # Builds image using metadata acquired by the agent.

# For testing
./gradlew -Pagent nativeTest # Runs on JVM with the native-image agent, collects the metadata and uses it for testing on native-image.
